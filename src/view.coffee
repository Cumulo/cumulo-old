
jsondiffpatch = require 'jsondiffpatch'
lodash = require 'lodash'

diffpatch = jsondiffpatch.create
  objectHash: (obj) -> obj.id

module.exports = class CumuloView
  constructor: (options) ->
    lodash.assign @, options
    @listen()

  sync: (state, scene) ->
    data = @render state, scene
    @syncSolution state, data
    state.cache[@cacheName] = lodash.cloneDeep data

  patch: (state, scene) ->
    data = @render state, scene
    lastData = lodash.cloneDeep state.cache[@cacheName]
    if lastData?
      diff = diffpatch.diff lastData, data
      if diff?
        @patchSolution state, diff
        state.cache[@cacheName] = lodash.cloneDeep data
    else
      @sync state, scene

  render: (state, scene) ->
    if state.userId?
    then @renderUser state, scene
    else @renderGuest()

# oeverwrite in project
  cacheName: null
  listen: ->
  syncSolution: (state, data) ->
  patchSolution: (state, data) ->
  renderUser: (state, scene) ->
  renderGuest: ->