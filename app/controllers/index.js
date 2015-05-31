var fs = require( 'fs' );
var path = require( 'path' );
exports.index = function ( req, res, next ) {
  return res.render( 'index' );
};
exports.about = function ( req, res, next ) {
  return res.render( 'about' );
};
exports.lyrics = function ( req, res, next ) {
  return res.render( 'lyrics' );
};
exports.download = function ( app ) {
  return function ( req, res, next ) {
    var ALBUM_ONE = 'LOD - A Struggle Makes Sense.zip';
    var dataAlbumFolder = path.resolve(
      app.get( 'basePath' ),
      'data',
      'albums'
    );//@todo move to config

    var file = path.join( dataAlbumFolder, "/", ALBUM_ONE );
    fs.exists( file, function ( isAvailable ) {

      if (isAvailable) {
        return res.download( file, ALBUM_ONE );
      } else {
        return res.status( 404 ).send( 'File Not Found' );
      }
    } );
  };
};
