/**
 * Created by Victor on 5/20/2015.
 */
'use strict';

var gulp = require( 'gulp' );
var sass = require( 'gulp-ruby-sass' );
var concatCss = require( 'gulp-concat-css' );
var config = { bowerDir: 'bower_components' };

gulp.task( 'css', function () {
  return sass( 'src/stylesheets', {
    loadPath: [
      config.bowerDir + '/bootstrap-sass-official/assets/stylesheets',
      config.bowerDir + '/fontawesome/scss'
    ],
    compass: true
  } )
    .pipe( concatCss( "main.css" ) )
    .pipe( gulp.dest( 'src/css/' ) );
} );
