
gulp = require 'gulp'

gulp.task 'coffee', ->
  coffee = require 'gulp-coffee'

  gulp
  .src 'src/**/*.coffee'
  .pipe coffee(bare: yes)
  .pipe gulp.dest('lib/')

gulp.task 'watch', ->
  watch = require 'gulp-watch'
  plumber = require 'gulp-plumber'
  coffee = require 'gulp-coffee'

  watch('./src/**/*.coffee')
  .pipe plumber()
  .pipe coffee(bare: yes)
  .pipe gulp.dest('lib/')