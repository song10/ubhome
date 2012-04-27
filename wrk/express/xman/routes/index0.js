
/*
 * GET home page.
 */
// couchDB

var Articler = require('../articler').Articler;
var article = new Articler('http://localhost', 5984);

var m_user;

exports.index = function(req, res) {
    //console.log('**index**');
    //console.log(req);
    if (! req.loggedIn) {
      res.redirect('/login');
      return;
    }

    var _user;
    if (req.session.auth) {
      //console.log(req.session.auth);
      if (req.session.auth.twitter) {
        //console.log("===req.session.auth.twitter===");
        //console.log(req.session.auth.twitter);
        _user = req.session.auth.twitter.user.screen_name;
      } else if (req.session.auth.google) {
        //console.log("===req.session.auth.google===");
        //console.log(req.session.auth.google);
        _user = req.session.auth.google.user.name;
      } else if (req.session.auth.facebook) {
        //console.log("===req.session.auth.facebook===");
        //console.log(req.session.auth.facebook);
        _user = req.session.auth.facebook.user.name;
      }
    }

    if (! _user) {
      res.redirect('/login');
      return;
    } else {
      m_user = _user;
    }

    return article.findAll(function(err, docs) {
      return res.render('index', {
        locals: {
          title: 'CouchPress',
          articles: docs,
          user: _user
        }
      });
    });
};

exports.login = function(req, res){
    //console.log('**login**');
    if (req.loggedIn) {
      res.redirect('/');
      return;
    }else{
      m_user = undefined;
    }

    res.render('login', {
      layout: false,
      locals: {
        title: "Login App",
        user: m_user
      }
    });
};

exports.new_get = function(req, res) {
    if (! req.loggedIn) {
      res.redirect('/login');
      return;
    }

    //console.log('**new_get**');
    return res.render('new', {
      locals: {
        title: 'CouchPress / New Post'
      }
    });
};

exports.new_post = function(req, res) {
    if (! req.loggedIn) {
      res.redirect('/login');
      return;
    }

    //console.log('**new_post**');
    return article.save({
      title: req.param('title'),
      body: req.param('body'),
      created_at: new Date()
    }, function(err, docs) {
      return res.redirect('/');
    });
};
