#
addUser = (source, sourceUser) ->
	user = undefined
	if arguments.length is 1
		user = sourceUser = source
		user.id = ++nextUserId
		return usersById[nextUserId] = user
	else
		user = usersById[++nextUserId] = id: nextUserId
		user[source] = sourceUser
	user

#
objectToString = (o) ->
	parse = (_o) ->
		a = []
		t = undefined
		for p of _o
			if _o.hasOwnProperty(p)
				t = _o[p]
				if t and typeof t is "object"
					a[a.length] = p + ":{ " + arguments_.callee(t).join(", ") + "}"
				else if typeof t is "string"
					a[a.length] = [ p + ": \"" + t.toString() + "\"" ]
				else
					a[a.length] = [ p + ": " + t.toString() ]
		a
	"{" + parse(o).join(", ") + "}"

#
String::keyMatch = (re, flags) ->
	is_global = false
	results = []
	keys = {}
	native_re = null
	str = this
	tmpstr = str
	flags = "" if flags is `undefined`
	tmpkeys = re.match(/(?!\(\?\P\<)(\w+)(?=\>)/g)
	unless tmpkeys
		return str.match(re)
	else
		i = 0
		l = tmpkeys.length
		while i < l
			keys[i] = tmpkeys[i]
			i++

	native_re = re.replace(/\?\P\<\w+\>/g, "")
	is_global = true if flags.indexOf("g") >= 0
	flags = flags.replace("g", "")
	native_re = RegExp(native_re, flags)
	loop
		tmpmatch = tmpstr.match(native_re)
		tmpkeymatch = {}
		tmpsubstr = ""
		if tmpmatch
			tmpsubstr = tmpmatch[0]
			tmpkeymatch[0] = tmpsubstr
			i = 1
			l = tmpmatch.length
			while i < l
				tmpkeymatch[keys[i - 1]] = tmpmatch[i]
				i++
			results.push tmpkeymatch
			tmpstr = tmpstr.slice((tmpstr.indexOf(tmpsubstr) + tmpsubstr.length))
		else
			tmpstr = ""
		break unless is_global and tmpstr.length > 0
	results

#
express = require("express")
params = require("express-params")
everyauth = require("everyauth")
routes = require("./routes")
conf = require("./config.json")
app = module.exports = express.createServer()

#params.extend app
#app.param "range", /^(\w+)\.\.(\w+)?$/
#app.param "fbcb", /^(auth)(.*)/

everyauth.helpExpress app,
	userAlias: "__user__"

usersById = {}
nextUserId = 0
usersByLogin = "admin@einopad.com": addUser(
	login: "admin@einopad.com"
	password: "einopad"
)

#
everyauth.password
	.loginWith("email")
	.getLoginPath("/login2")
	.postLoginPath("/login2")
	.loginView("login2.jade")
	.loginLocals((req, res, done) ->
		setTimeout (->
			done null,
				title: "Async login"
		), 200
	)
	.authenticate((login, password) ->
		errors = []
		errors.push "Missing login"	unless login
		errors.push "Missing password"	unless password
		return errors if errors.length
		user = usersByLogin[login]
		return [ "Login failed" ] unless user
		return [ "Login failed" ] if user.password isnt password
		user
	)
	.getRegisterPath("/register")
	.postRegisterPath("/register")
	.registerView("register.jade")
	.registerLocals((req, res, done) ->
		setTimeout (->
			done null,
				title: "Async Register"
		), 200
	)
	.validateRegistration((newUserAttrs, errors) ->
		login = newUserAttrs.login
		errors.push "Login already taken" if usersByLogin[login]
		errors
	)
	.registerUser((newUserAttrs) ->
		login = newUserAttrs[@loginKey()]
		usersByLogin[login] = addUser(newUserAttrs)
	)
	.loginSuccessRedirect("/")
	.registerSuccessRedirect "/"
#
everyauth.twitter
	.consumerKey(conf.twit.consumerKey)
	.consumerSecret(conf.twit.consumerSecret)
	.findOrCreateUser((session, token, secret, user) ->
		@Promise().fulfill user
	)
	.redirectPath "/"
#
everyauth.facebook
	.myHostname("http://einopad.mooo.com")
	.appId(conf.fb.appId)
	.appSecret(conf.fb.appSecret)
	.findOrCreateUser((session, accessToken, accessTokExtra, fbUserMetadata) ->
		@Promise().fulfill fbUserMetadata
	)
	.moduleTimeout(-1).redirectPath "/"
#
everyauth.google
	.appId(conf.google.appId)
	.appSecret(conf.google.appSecret)
	.callbackPath("/oauth2callback")
	.scope("https://www.googleapis.com/auth/userinfo.profile")
	.findOrCreateUser((session, accessToken, accessTokenExtra, googleUserMetadata) ->
		@Promise().fulfill googleUserMetadata
	)
	.moduleTimeout(-1)
	.redirectPath "/"
#
app.configure ->
	app.set "views", __dirname + "/views"
	app.set "view engine", "jade"
	app.use express.bodyParser()
	app.use express.methodOverride()
	app.use express.cookieParser()
	app.use express.session(secret: "DinoPadServiceSystem001")
	app.use require("stylus").middleware(src: __dirname + "/public")
	app.use everyauth.middleware()
	app.use app.router
	app.use express["static"](__dirname + "/public")
#
app.configure "development", ->
	app.use express.errorHandler(
		dumpExceptions: true
		showStack: true
	)
#
app.configure "production", ->
	app.use express.errorHandler()
#
app.listen 8080, ->
	console.log "Express server listening on port %d in %s mode", app.address().port, app.settings.env
#
app.get "/", routes.index
app.get "/home", routes.home
app.get "/list", routes.list
app.get "/login", routes.login
app.get "/new", routes.new_get
app.post "/new", routes.new_post
app.get "/order", routes.order_get
app.post "/order", routes.order_post
app.get "/jqui/:userId", routes.jqui

#
exports.everyauth = everyauth
