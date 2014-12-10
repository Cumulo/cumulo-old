
time = require './util/time'

module.exports = class CumuloScene
  constructor: (options) ->
    @data = {}
    @changed = no

    @duration = options.duration or 400
    @render = options.render
    @broadcast = options.broadcast

    @startLoop()

  startLoop: ->
    time.repeat =>
      @detectChange()
    , @duration

  detectChange: ->
    if @changed
      @data = @render()
      @changed = no
      @broadcast()

  render: ->
    # overwrite this in project
  broadcast: ->
    # overwrite this in project
