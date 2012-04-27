
/**
 * Module dependencies.
 */

var express = require('express')
  , params = require('express-params')
  , routes = require('./routes');

var app = module.exports = express.createServer();
params.extend(app);

app.param('range', /^(\w+)\.\.(\w+)?$/);
//app.param('fbcb', /^(auth\/facebook\/callback\?code=.+)#_=_$/);
app.param('fbcb', /^(auth)(.*)/);

// everyauth

var everyauth = require('everyauth');
//everyauth.helpExpress(app);
everyauth.helpExpress(app, { userAlias: '__user__' });

var conf = require('./config.json');
everyauth.twitter
  .consumerKey(conf.twit.consumerKey)
  .consumerSecret(conf.twit.consumerSecret)
  .findOrCreateUser(function(session, token, secret, user) {
    return this.Promise().fulfill(user);
  })
  .redirectPath('/');

everyauth.facebook
  .myHostname('http://song10.mooo.com:8080')
//  .accessTokenHttpMethod('get')
//  .postAccessTokenParamsVia('query')
  .appId(conf.fb.appId)
  .appSecret(conf.fb.appSecret)
//  .scope('email')
//  .moduleTimeout(30000)
  //.handleAuthCallbackError(function (req, res) {
    //// If a user denies your app, Facebook will redirect the user to
    //// /auth/facebook/callback?error_reason=user_denied&error=access_denied&error_description=The+user+denied+your+request.
    //// This configurable route handler defines how you want to respond to
    //// that.
    //// If you do not configure this, everyauth renders a default fallback
    //// view notifying the user that their authentication failed and why.
  //})
  .findOrCreateUser(function (session, accessToken, accessTokExtra, fbUserMetadata) {
    console.log('**fbUserMetadata**');
    console.log(fbUserMetadata);
    return this.Promise().fulfill(fbUserMetadata);
    })
  .moduleTimeout(-1)
  .redirectPath('/');

//console.log(everyauth.facebook.configurable());
//console.log(everyauth.facebook.callbackPath());
//console.log(everyauth.facebook.routes);

// Google
everyauth.google
  .appId(conf.google.appId)
  .appSecret(conf.google.appSecret)
  .callbackPath('/oauth2callback')
//  .scope('http://www.google.com/calendar/feeds/')
//  .scope('https://www.googleapis.com/auth/userinfo.email')
  .scope('https://www.googleapis.com/auth/userinfo.profile')
    //.handleAuthCallbackError( function (req, res) {
    //// If a user denies your app, Google will redirect the user to
    //// /auth/facebook/callback?error=access_denied
    //// This configurable route handler defines how you want to respond to
    //// that.
    //// If you do not configure this, everyauth renders a default fallback
    //// view notifying the user that their authentication failed and why.
  //})
  .findOrCreateUser( function (session, accessToken, accessTokenExtra, googleUserMetadata) {
    //console.log(googleUserMetadata);
    return this.Promise().fulfill(googleUserMetadata);
    })
  .moduleTimeout(-1)
  .redirectPath('/');

// Configuration

app.configure(function(){
  app.set('views', __dirname + '/views');
  app.set('view engine', 'jade');
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(express.cookieParser());
  app.use(express.session({ secret: 'xmanagesys001' }));
  app.use(require('stylus').middleware({ src: __dirname + '/public' }));
  app.use(everyauth.middleware());
  app.use(app.router);
  app.use(express.static(__dirname + '/public'));
});

app.configure('development', function(){
  app.use(express.errorHandler({ dumpExceptions: true, showStack: true }));
});

app.configure('production', function(){
  app.use(express.errorHandler());
});

// listen

app.listen(8080, function(){
  console.log("Express server listening on port %d in %s mode", app.address().port, app.settings.env);
});

// sub
function objectToString(o){
    var parse = function(_o){
        var a = [], t;
        for(var p in _o){
            if(_o.hasOwnProperty(p)){
                t = _o[p];
                if(t && typeof t == "object"){
                    a[a.length]= p + ":{ " + arguments.callee(t).join(", ") + "}";
                } else if(typeof t == "string"){
                    a[a.length] = [ p+ ": \"" + t.toString() + "\"" ];
                } else {
                    a[a.length] = [ p+ ": " + t.toString()];
                }
            }
        }
        return a;
    }
    return "{" + parse(o).join(", ") + "}";
}

String.prototype.keyMatch = function(re, flags){
    var is_global = false,
        results = [],
        keys = {},
        native_re=null,
        str = this,
        tmpstr = str;

    if(flags === undefined)
        flags = "";

    // find the keys inside the re, and place in mapping array {'1':'key1', '2':'key2', ...}
    var tmpkeys = re.match(/(?!\(\?\P\<)(\w+)(?=\>)/g);
    if(!tmpkeys){  // no keys, do a regular match
        return str.match(re);
    }else{
        for(var i=0,l=tmpkeys.length; i<l; i++){
            keys[i] = tmpkeys[i];
        }
    }

    // remove keys from regexp leaving standard regexp
    native_re = re.replace(/\?\P\<\w+\>/g,'');

    if(flags.indexOf('g') >= 0)
        is_global = true;
    flags = flags.replace('g','');

    native_re = RegExp(native_re, flags);
    do{
        // parse string
        var tmpmatch = tmpstr.match(native_re),
            tmpkeymatch = {},
            tmpsubstr = "";

        if(tmpmatch){
            // get the entire string found
            tmpsubstr = tmpmatch[0];
            tmpkeymatch[0] = tmpsubstr;
            // map them back out
            for(var i=1,l=tmpmatch.length; i<l; i++){
                tmpkeymatch[keys[i-1]] = tmpmatch[i];
            }
            // add to results
            results.push(tmpkeymatch);
            tmpstr = tmpstr.slice( (tmpstr.indexOf(tmpsubstr)+tmpsubstr.length) );
        }else{
            tmpstr = "";
        }
    } while(is_global && tmpstr.length > 0) // if global loop until end of str, else do once

    return results;
}

// Routes

app.get('/', routes.index);
app.get('/login', routes.login);

app.get('/new', routes.new_get);
app.post('/new', routes.new_post);

// facebook workaround
//app.get('/test/:id/?$', function(req,res) {
  //res.send(objectToString(req.params));
  //console.log(req.params);
  //});
//app.get('/test2/:range', function(req,res) {
  ////console.log(req.params);
  //var results = req.params.range[0].keyMatch('(?P<num1>\\w+)\\.\\.(?P<num2>\\d+)', "g");
  ////console.log(results);
  //res.send(objectToString(req.params)+'<br/>'+objectToString({'fbcb': results[0]}));
  //});
app.get('*', function(req,res) {
  //console.log('**REQ**');
  //console.log(req.url);
  var results = req.url.keyMatch('^(/auth/facebook/callback\\?code=.+)$', "g");
  //console.log('**RZ**');
  //console.log(results);
  if (!results) {
    console.log('**404**');
    console.log(req.url);
    res.send(404);
  }else{
    res.send(objectToString(req.url)+'<br/>'+objectToString({'fbcb': results[0]}));
  }
  //console.log('**END**');
  });
