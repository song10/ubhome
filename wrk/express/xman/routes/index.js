
/*
 * GET home page.
 */

exports.index = function(req, res) {
    var user;
    if (req.session.auth) {
      if (req.session.auth.twitter) {
        console.log("===req.session.auth.twitter===");
        console.log(req.session.auth.twitter);
        user = req.session.auth.twitter.user.screen_name;
      } else if (req.session.auth.google) {
        console.log("===req.session.auth.google===");
        console.log(req.session.auth.google);
        user = req.session.auth.google.user.name;
      }
    }

    if (! user) {
      res.redirect('/login');
      return;
    }

    return article.findAll(function(err, docs) {
      return res.render('index', {
        locals: {
          title: 'CouchPress',
          articles: docs,
          user: user
        }
      });
    });
};

exports.login = function(req, res){
    var user;
    if (req.session.auth) {
      if (req.session.auth.twitter) {
        user = req.session.auth.twitter.user.screen_name;
      } else if (req.session.auth.google) {
        //console.log(req.session.auth.google);
        user = req.session.auth.google.user.name;
      }
    }

    if (user) {
      res.redirect('/');
      return;
    }

    res.render('login', {
      layout: false,
      locals: {
        title: "Login App",
        user: user
      }
    });
};

exports.new_get = function(req, res) {
    return res.render('new', {
      locals: {
        title: 'CouchPress / New Post'
      }
    });
};

// couchDB
var Articler = require('../articler').Articler;
var article = new Articler('http://localhost', 5984);

exports.new_post = function(req, res) {
    return article.save({
      title: req.param('title'),
      body: req.param('body'),
      created_at: new Date()
    }, function(err, docs) {
      return res.redirect('/');
    });
};

exports.fb_wa = function(req, res) {
    console.log(req);
    //res.redirect(req.param[0]);
    res.send(req);
};
