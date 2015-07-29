/**
 * Created by Victor on 5/19/2015.
 */
var express = require( 'express' );
var app = express();

var bodyParser = require( "body-parser" );
var routes = require( './app/routes.js' );

app.use(express.static(__dirname + '/src'));
app.set( 'view engine', 'jade' );
app.set( 'views', __dirname + '/views' );
app.set( 'basePath', __dirname );

app.use( bodyParser() );
routes( app );
app.listen( 80, function () {
  console.log('Light of Disaster app listening at 80 port');
} );

