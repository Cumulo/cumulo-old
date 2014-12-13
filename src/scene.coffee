
lodash = require 'lodash'
time = require './util/time'

module.exports = class CumuloScene
  constructor: (options) ->
    # initial data from project
    lodash.assign @, options

    @data = @render()
    @changed = no
    @startLoop()
    @listen()

  startLoop: ->
    time.interval @duration, =>
      @detectChange()

  detectChange: ->
    if @changed
      @data = @render()
      @changed = no
      @broadcast()

  get: ->
    lodash.cloneDeep @data

  # overwrite this in project
  data: null
  duration: 400
  render: ->
  broadcast: ->
  listen: ->
