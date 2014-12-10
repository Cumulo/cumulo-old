
records = []

exports.register = (state) ->
  records.push state

exports.unregister = (state) ->
  records = records.filter (obj) ->
    obj isnt state

exports.each = (f) ->
  records.forEach f