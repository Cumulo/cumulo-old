
lodash = require 'lodash'
Dispatcher = require './util/dispatcher'

module.exports = class CumuloStore extends Dispatcher
  constructor: (options) ->
    @data = options.data
    super

  replace: (data) ->
    @data = data
    @dispatch()

  clone: ->
    lodash.cloneDeep @data
