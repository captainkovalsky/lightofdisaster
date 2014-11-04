gulp = require 'gulp'
$ = (require 'gulp-load-plugins')()
livereload = require 'gulp-livereload'
nodemon = require 'gulp-nodemon'
express = require 'express'
path = require 'path'
app = express()

gulp.task 'compass', =>
  gulp.src './src/stylesheets/*.sass'
  .pipe $.plumber()
  .pipe $.compass {
    css: 'dist/stylesheets'
    sass: 'src/stylesheets'
  }
  .pipe gulp.dest 'dist/stylesheets'
  .pipe livereload()


gulp.task 'coffee', =>
  gulp.src 'src/scripts/main.coffee', {read: false}
  .pipe $.plumber()
  .pipe $.browserify {
    debug: true
    insertGlobals: false
    transform: ['coffeeify']
    extensions: ['.coffee']
  }
  .pipe $.rename 'app.js'
  .pipe gulp.dest 'dist/scripts'
  .pipe livereload()


gulp.task 'images', =>
  gulp.src './src/images/'
  .pipe gulp.dest './dist/images'

gulp.task 'templates', =>
  gulp.src 'src/*.jade'
  .pipe $.plumber()
  .pipe $.jade {
    pretty: true
  }
  .pipe gulp.dest 'dist/'
  .pipe livereload()

gulp.task 'express', =>
  app.use express.static(path.resolve './dist')
  app.listen 1337
  $.util.log 'Listening on port: 1337'

gulp.task 'watch', =>
  livereload.listen()
  gulp.watch 'src/stylesheets/*.sass', ['compass']
  gulp.watch 'src/scripts/*.coffee', ['coffee']
  gulp.watch 'src/*.jade', ['templates']
  $.notify {message: "Reload"}


gulp.task 'default', ['demon']
gulp.task 'run-dev', ['images', 'express', 'watch']
gulp.task 'demon', =>
  nodemon {
    script: 'dist/scripts/app.js'
    ext: 'js'
    env: {'NODE_ENV': 'development'}
    nodeArgs: ['--debug=9999']
  }
  .on 'start', ['run-dev']
  .on 'change', ['watch']
