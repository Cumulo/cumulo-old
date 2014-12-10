
path = require 'path'
fs = require 'fs'
time = require './util/time'

dbPath = path.join __dirname, 'database.json'

exports.init = (options) ->
  # required options
  dbPath = options.dbPath
  initialDatabase = options.initialDatabase
  shrinkDatabase = options.shrinkDatabase

  try
    raw = fs.readFileSync dbFile, 'utf8'
    database = JSON.parse raw

  unless database?
    database = initialDatabase

  time.repeat 10000, ->
    console.info 'persistent database', (new Date)
    database = shrinkDatabase()
    raw = JSON.stringify database, null, 2
    fs.writeFileSync dbPath, raw
