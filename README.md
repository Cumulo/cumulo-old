
Cumulo: Flux like architecture on server
----

Cumulo is a realtime framework for small apps.
It's designed like Flux to work with React.

### Action Schema

This is the schema of actions used to connect server and clients:

```coffee
action =
  name: 'scope/behavior'
  data: "JSON Data"
```

### Usage

```coffee
npm i --save cumulo
```

Here are the methods and constructors exposed:

```coffee
exports.router = require './router'
exports.database = require './database'

exports.State = require './state'
exports.Store = require './store'
exports.Scene = require './scene'
exports.View = require './view'

exports.push = (state, name, data) ->
  action = {name, data}
  raw = JSON.stringify action, null, 2
  state.ws.send raw
```

#### State

State needs to be intrdoces first, it's plain Object.

* `.userId` will be used to detect if used logined.
* `.cache` is a place for holding cache, and removed with state
* `.ws` is also important, cumulo uses `state.ws` to push data to client

```coffee
wss = new Server port: 3000
wss.on 'connection', (ws) ->

  state =
    # states will dispatch based on userId?
    userId: null
    id: shortid.generate()
    cache: {}
    ws: ws
    userId: null
    page:
      message: 1
      thread: 1
      step: 5
```

#### Router

```coffee
cumulo = require 'cumulo'
router = cumulo.router

# for debugging
router.display = (state, action) ->
  console.log state.userId, action

# events in router are mostly actions from websocket
ws.on 'message', (raw) ->
  data = JSON.parse raw
  router.dispatch state, data

# and we will do this in a store
router.register 'account/login', (state, data) ->
```

#### Database

It's actually a JSON in memory, with frequently writing to disk:

```coffee
cumulo = require 'cumulo'

cumulo.database.init
  # how long does it saves to disk
  duration: 100000

  dbPath: path.join __dirname, '../data/database.json'

  initialData:
    # JSON object

  gatherData: ->
    # collect data before saving

  onLoad: (json) ->
    # get JSON data, and dispatch to stores
```

#### State

And example of state, actually it's states of all websockets.
First you need to define a file named `states`:


```coffee
cumulo = require 'cumulo'
lodash = require 'lodash'

router = cumulo.router
states = new cumulo.State

module.exports = states

router.register 'state/morePage', (state, data) ->
  # it's also a dispatcher listened by scenes
  states.dispatch state
```

and with `.record` `.unrecord` to keep track of all states:

```coffee
states.record state
console.info 'state record', state.id
ws.on 'close', ->
  states.unrecord state
  console.info 'state unrecord', state.id
  state = null
```

#### Store

```coffee
cumulo = require 'cumulo'
router = cumulo.router

# initial data will be used in patching
# and it's mostly [] or {}
store = new cumulo.Store data: []

# store responds to router, and it's a dispatcher listend by scene too
router.register 'profile/add', (state, data) ->
  store.data.push data
  store.dispatch()
```

#### Scene

```coffee
cumulo = require 'cumulo'

states = require '../states'
client = require '../view/client'

module.exports = new cumulo.Scene
  # default value
  data: {}
  # duration of the looper to check .changed
  duration: 400

  broadcast: ->
    # define how to notify all clients
    states.each (state) =>
      client.patch state, world: @get()

  listen: ->
    # when store changes, mark this scene changed
    messagesStore.register =>
      @changed = yes
    # when state changes, call view patching
    states.register (state) =>
      client.patch state, world: @get()

  render: ->
    # returns an object representing the whole world
```

#### View

View represents a single user's perspective of a scene:

```coffee
cumulo = require 'cumulo'
lodash = require 'lodash'

module.exports = new cumulo.View
  # a name to caching data in state.cache
  cacheName: 'client'

  # here we use comulo.push to send data
  syncSolution: (state, data) ->
    cumulo.push state, 'client/sync', data

  patchSolution: (state, data) ->
    cumulo.push state, 'client/patch', data

  # renderer when state.userId is null
  renderGuest: ->
    # JSON data, will be diffed

  # renderer when state.userId is defined, meaning loginged
  renderUser: (state, scene) ->
    # JSON data, will be diffed
```

See [chat-distract][chat-distract] for Details.

[chat-distract]: https://github.com/Cumulo/chat-distract/tree/master/source

### License

MIT