exp = require 'express'
app = exp.createServer()
routes = require './routes'
module.exports = app

io = require('socket.io').listen app
io.sockets.on 'connection', (socket) ->
    socket.on 'send', (data) ->
        socket.broadcast.emit 'distribute', data

app.configure ->
    app.set 'view engine', 'jade'
    app.set 'views', __dirname + '/views'
    app.use exp.static __dirname + '/public'
    app.use exp.bodyParser()
    app.use exp.methodOverride()
    app.use app.router

app.configure 'development', ->
    app.use exp.errorHandler { dumpExceptions: true, showStack: true }

app.configure 'production', ->
    app.use exp.errorHandler()

app.listen 8080
console.log "Express server listening on port %d in %s mode", app.address().port, app.settings.env

app.get '/', routes.index
