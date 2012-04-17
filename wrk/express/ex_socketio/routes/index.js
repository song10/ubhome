
/*
 * GET home page.
 */

exports.index = function(req, res){
  res.render('index', { title: 'Express' })
};

exports.test = function(req, res){
  console.log(__dirname + '/index.html');
  res.sendfile(__dirname + '/index.html');
};
