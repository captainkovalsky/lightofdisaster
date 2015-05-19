/**
 * Created by Victor on 5/19/2015.
 */
var express = require( 'express' );
var app = express();

var bodyParser = require( "body-parser" );
var routes = require( './app/routes.js' );

app.set( 'view engine', 'jade' );
app.set( 'views', __dirname + '/views' );
app.set( 'basePath', __dirname );
app.use( bodyParser() );
app.use( express.static( './dist' ) );
routes( app );
app.listen( 5000 );

