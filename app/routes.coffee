#this is the main file that pulls in all other modules
index = require("./controllers/index.coffee")

module.exports = (app) ->
  app.get "/", index.index
  app.get "/about", index.about
  app.get "/lyrics", index.lyrics
