
lodash = require 'lodash'
Dispatcher = require './util/dispatcher'

module.exports = class CumuloState extends Dispatcher
  constructor: (options) ->
    super
    lodash.assign @, options
    @records = []

  record: (state) ->
    @records.push state

  unrecord: (state) ->
    @records = @records.filter (obj) ->
      obj isnt state

  each: (f) ->
    @records.forEach (state) ->
      f state

  # rewrite in project
  sync: ->
  patch: ->