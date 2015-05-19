var index;
index = require( "./controllers/index.coffee" );
module.exports = function ( app ) {
  app.get( "/", index.index );
  app.get( "/about", index.about );
  app.get( "/lyrics", index.lyrics );
  return app.get( "/download/album/:name/", index.download( app ) );
};
