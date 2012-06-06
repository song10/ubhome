#!/usr/bin/env node
var nopt = require('nopt')
var fs = require('fs')
var dot = require('dot')

try { var d4 = require('d4.json') } catch(e) {}

var print = console.log
var merge = function (obj1, obj2) {
	var obj3 = {}
	for (var attrname in obj1) { obj3[attrname] = obj1[attrname] }
	for (var attrname in obj2) { obj3[attrname] = obj2[attrname] }
	return obj3
}

var knownOpts = {
	"template" : [String, null],
	"init" : Boolean,
	"force": Boolean
	}
var opt = nopt(knownOpts)
//console.log(opt)

//require('jquery').extend(opt, d4)
opt = merge(d4, opt)

function test () {
	print(__filename)
	print(__dirname)
}
test()

if (! opt.template) {
	print('no template given, abort!')
	process.exit(1)
}

dot.templateSettings.strip = false

var temp = fs.readFileSync(opt.template,'utf-8')
var fn = dot.template(temp)

opt.argv.remain.forEach(function(x) {
	var json = require(x)
	json = merge(opt, json)
	var render = fn(json)

	print(render)
})
