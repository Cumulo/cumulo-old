
exports.now = ->
  (new Date).toISOString()

exports.interval = (f, t) -> setInterval t, f
exports.timeout = (f, t) -> setTimeout t, f