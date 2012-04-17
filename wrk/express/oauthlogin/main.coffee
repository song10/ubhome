# Requires and Variables
exp = require 'express'
app = exp.createServer()
routes = require('./routes')

everyauth = require 'everyauth'
everyauth.twitter
    .consumerKey('txEsSAyAdBVp1UJXz10Hg')
    .consumerSecret('gi0QzE3l7ShhPpwuh8bNRj4JeMOn5i3tatg41F0aw')
    .findOrCreateUser((session, token, secret, user) ->
        promise = @.Promise().fulfill user
    ).redirectPath '/'

# App Configuration
app.configure () ->
    app.set 'view engine', 'jade'
    app.set 'views', __dirname + '/views'
    app.use exp.static __dirname + '/views'
    app.use exp.bodyParser()
    app.use exp.methodOverride()
    app.use exp.cookieParser()
    app.use exp.session {secret: 'bobsyouruncle'}
    app.use everyauth.middleware()
    app.use app.router

app.listen 8080
console.log 'Server running at http://localhost:8080'

# Routes
app.get '/', routes.index
app.get '/x', (res, req) ->
    if ('session' in req and 'auth' in req.session and req.session.auth.twitter.user)
        user = req.session.auth.twitter.user.screen_name;

    res.render('index', {
        layout: false
        locals: {user: user}
    })
