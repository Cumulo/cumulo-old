
path = require 'path'
fs = require 'fs'
time = require './util/time'
lodash = require 'lodash'


module.exports =
  init: (options) ->
    lodash.assign @, options
    @dbPath

    @loadDisk()
    @startSaving()

  loadDisk: ->
    try
      raw = fs.readFileSync @dbPath, 'utf8'
      database = JSON.parse raw
    catch error
      console.error 'error parsing database', error
      database = @initialData

    # trigger onLoad event
    @onLoad database

  startSaving: ->
    time.interval @duration, =>
      @saveData()

  saveData: ->
    console.info 'persistent database', (new Date)
    database = @gatherData()
    raw = JSON.stringify database, null, 2
    fs.writeFileSync @dbPath, raw

  # rewrite in project
  dbPath: 'database.json'
  duration: 10000
  initialData: ->
  gatherData: ->
  onLoad: ->
