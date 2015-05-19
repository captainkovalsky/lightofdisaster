var fs, path;
fs = require( 'fs' );
path = require( 'path' );
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
  console.log( 'download with app var ', app );
  return function ( req, res, next ) {
    var albumName, basePath, dataAlbumFolder, returnAlbum;
    albumName = req.param( 'name', null );
    basePath = app.get( 'basePath' );
    dataAlbumFolder = path.resolve( basePath, '..', 'data', 'albums' );
    returnAlbum = function ( albumZipFile ) {
      var file;
      file = path.join( dataAlbumFolder, "/", albumZipFile );
      return res.download( file, albumZipFile );
    };
    switch ( albumName ) {
      case null:
        return res.send( 'Bad Request' );
      case 'struggle-makes-sense':
        return returnAlbum( 'LOD - A Struggle Makes Sense.zip' );
      default:
        return res.send( "Album doesn't exist" );
    }
  };
};
