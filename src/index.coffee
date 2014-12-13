
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