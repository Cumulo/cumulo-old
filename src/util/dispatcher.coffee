
module.exports = class CumuloDispatcher
  constructor: ->
    @_listeners = []

  dispatch: ->
    @_listeners.forEach (cb) =>
      cb()

  register: (cb) ->
    if cb in @_listeners
    then console.warn 'alreay listening'
    else @_listeners.push cb

  unregister: (cb) ->
    match = (f) -> f is cb
    @_listeners = lodash.remove @_listeners, match
