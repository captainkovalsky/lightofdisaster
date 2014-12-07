exports.index = (req, res, next) ->
  res.render('index')
exports.about = (req, res, next) ->
  res.render('about')
exports.lyrics = (req, res, next) ->
  res.render('lyrics')

exports.download = (req, res, next) ->
  res.download('test', 'test.txt')


