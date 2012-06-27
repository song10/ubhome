exports.index = (req, res) ->
	res.render "index",
		title: "Express"

exports.client = (req, res) ->
	res.render "client",
		layout: false
