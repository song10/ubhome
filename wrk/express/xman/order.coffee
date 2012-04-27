# Order Class - Handles all order functions
cradle = require 'cradle'

class Order
	constructor: (host, port, db) ->
		@dbname = db
		@connect = new cradle.Connection host, port, {
			cache: true
			raw: false
		}
		@db = @connect.database @dbname

	findAll: (callback) ->
		@db.view @dbname+'/all', {descending: true}, (err, res) ->
			if (err)
				callback err
			else
				docs = []
				res.forEach (row) ->
					docs.push row
				callback null, docs

	save: (articles, callback) ->
		@db.save articles, (err, res) ->
			if (err)
				callback err
			else
				callback null, articles

exports.Order = Order
