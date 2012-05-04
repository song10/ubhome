Order = require("../order").Order
order = new Order("http://localhost", 5984, "einopad")

m_user = undefined

exports.index = (req, res) ->
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

	unless _user
		res.redirect "/login"
		return
	else
		m_user = _user

	order.findAll (err, docs) ->
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

path = require("path");
exports.jqui = (req, res) ->
    filepath = path.normalize( __dirname + "/../public/selectable.html");
    console.log( filepath );
    res.sendfile( filepath );

