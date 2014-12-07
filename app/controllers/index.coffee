fs = require 'fs'
path = require 'path'

exports.index = (req, res, next) ->
  res.render('index')

exports.about = (req, res, next) ->
  res.render('about')

exports.lyrics = (req, res, next) ->
  res.render('lyrics')

exports.download = (app) ->
  console.log 'download with app var ', app
  (req, res, next) ->
    albumName = req.param 'name', null
    basePath = app.get 'basePath'
    dataAlbumFolder = path.resolve basePath, '..', 'data', 'album'

    returnAlbum = (albumZipFile) ->
      file = path.join dataAlbumFolder, "/", albumZipFile
      res.download file, albumZipFile

    switch albumName
      when null then res.send 'Bad Request'
      when 'struggle-makes-sense' then returnAlbum 'LOD - A Struggle Makes Sense.zip'
      else
        res.send "Album doesn't exist"


