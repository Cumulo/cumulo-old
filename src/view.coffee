
jsondiffpatch = require 'jsondiffpatch'

diffpatch = jsondiffpatch.create
  objectHash: (obj) -> obj.id

module.exports = class CumuloView
  constructor: (options) ->
    @render = options.render
    @getCache = options.getCache
    @setCache = options.setCache
    @syncSolution = options.syncSolution
    @patchSolution = options.patchSolution

  sync: (state) ->
    data = @render()
    @syncSolution data
    @setCache data

  patch: ->
    data = @render()
    diff = diffpatch.diff @getCache(), data
    @patchSolution data
    @setCache data

  render: ->
    # overwrite in project
  getCache: ->
    # overwrite in project
  setCache: ->
    # overwrite in project
  syncSolution: ->
    # overwrite in project
  patchSolution: ->
    # overwrite in project