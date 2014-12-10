
routes = {}

exports.dispatch = (state, action) ->
  handler = routes[action.name]
  if handler?
  then handler state, action.data
  else console.warn 'router handler is not found', action

exports.register = (name, cb) ->
  if routes[name]?
    console.warn 'rewriting router handler'
  routes[name] = cb
