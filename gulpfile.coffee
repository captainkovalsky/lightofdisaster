gulp = require 'gulp'
$ = (require 'gulp-load-plugins')()
livereload = require 'gulp-livereload'
nodemon = require 'gulp-nodemon'
concat = require 'gulp-concat'
express = require 'express'
path = require 'path'
sass = require 'gulp-ruby-sass'
pngquant = require 'imagemin-pngquant'
session = require('express-session')
cookieParser = require('cookie-parser')
bodyParser = require("body-parser")

app = module.exports.app = exports.app = express()
routes = require './app/routes.coffee'

gulp.task 'coffee', =>
  gulp.src './app/routes.coffee', {read: false}
  .pipe $.plumber()
  .pipe $.browserify {
    debug: true
    insertGlobals: false
    transform: ['coffeeify']
    extensions: ['.coffee']
  }
  .pipe $.rename 'app.js'
  .pipe gulp.dest 'dist/scripts'

gulp.task 'images', =>
  gulp.src './src/images/**/*'
#  .pipe $.imagemin {
#    progressive: true
#    use: [pngquant({quality: '65-80', speed: 4})]
#  }
  .pipe gulp.dest './dist/images/'


gulp.task 'express', =>
  app.set 'view engine', 'jade'
  app.set 'views', __dirname + '/views'
  app.set 'basePath', __dirname
  app.use bodyParser()
  app.use express.static './dist'
  routes app
  app.listen 1337
  $.util.log 'Listening on port: 1337'

gulp.task 'templates', =>
  gulp.src 'src/*.jade'
  .pipe livereload()

gulp.task 'watch', =>
  livereload.listen()
  gulp.watch 'src/scripts/*.coffee', ['coffee']
  gulp.watch './src/images/**/*', ['images']
  gulp.watch './views/**/*', ['templates']
  $.notify {message: "Reload"}

gulp.task 'fonts', =>
  gulp.src 'src/fonts/**'
  .pipe gulp.dest 'dist/fonts'

gulp.task 'dev', ['fonts', 'watch', 'express', 'demon']

gulp.task 'default', ['express', 'demon-prod']
gulp.task 'dev', ['express', 'demon-dev']

gulp.task 'demon-dev', =>
  nodemon {
    script: 'dist/scripts/app.js'
    env: {'NODE_ENV': 'development'}
    nodeArgs: ['--debug=9999']
  }

gulp.task 'demon-prod', =>
  nodemon {
    script: 'dist/scripts/app.js'
    env: {'NODE_ENV': 'production'}
  }
