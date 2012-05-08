Order = require("../order").Order
order = new Order("http://localhost", 5984, "einopad")

m_user = undefined

exports.index = (req, res) ->
	res.redirect "/home"
	return

exports.home = (req, res) ->
	res.render "home",
		layout: false
		locals: `undefined`

exports.list = (req, res) ->
	order.findAll (err, docs) ->
		if `undefined` == docs
			docs = {}
		res.render "list",
			layout: false
			locals:
				title: "Eino Pad Order List"
				orders: docs

exports.list0 = (req, res) ->
	unless req.loggedIn
		res.redirect "/login"
		return
	_user = undefined
	if req.session.auth
		if req.session.auth.twitter
			_user = req.session.auth.twitter.user.screen_name
		else if req.session.auth.google
			_user = req.session.auth.google.user.name
		else if req.session.auth.facebook
			_user = req.session.auth.facebook.user.name
		else if req.session.auth.userId
			_user = req.session.auth.userId
#			console.log req.session.auth

	unless _user
		res.redirect "/login"
		return
	else
		m_user = _user

	order.findAll (err, docs) ->
		if `undefined` == docs
			docs = {}
		res.render "index",
			locals:
				title: "Eino Pad Order"
				orders: docs
				user: _user

exports.login = (req, res) ->
	if req.loggedIn
		res.redirect "/"
		return
	else
		m_user = `undefined`

	res.render "login",
		layout: false
		locals:
			title: "Login App"
			user: m_user

exports.new_get = (req, res) ->
	unless req.loggedIn
		res.redirect "/login"
		return
	res.render "new",
		locals:
			title: "Eino Pad Order / New Order"

exports.new_post = (req, res) ->
	unless req.loggedIn
		res.redirect "/login"
		return

	order.save
		title: req.param("title")
		body: req.param("body")
		created_at: new Date()
		, (err, docs) ->
			res.redirect "/"

exports.order_get = (req, res) ->
	unless req.loggedIn
		res.redirect "/login"
		return
	res.render "order",
		locals:
			title: "Eino Pad Order / New Order"

exports.order_post = (req, res) ->
	unless req.loggedIn
		res.redirect "/login"
		return

	order.save
		client: req.param("client")
		type: req.param("type")
		due: req.param("due")
		quantity: req.param("quantity")
		priority: req.param("priority")
		serial: req.param("serial")
		EWD: req.param("EWD")
		created_at: new Date()
		, (err, docs) ->
			res.redirect "/"

path = require("path")
exports.jqui = (req, res) ->
#	console.log req.query
#	console.log req.query.page
#	console.log req.params
#	console.log req.params[0]
#	filepath = path.normalize (__dirname + "/../public/jqui/" + req.params.userId + ".html")
#	console.log filepath
#	res.sendfile filepath

	filepath = "jqui/"+req.params.userId
#	console.log filepath
	res.render filepath,
		layout: false
		locals: `undefined`
