var nopt = require('nopt')
	, fs = require('fs')
	, dot = require('dot')

var print = console.log;

var knownOpts = { "template" : [String, null] }
var opt = nopt(knownOpts)
//print(opt)

if (! opt.template) {
	print('no template given, abort!')
	process.exit(1)
}

var temp = fs.readFileSync(opt.template)
//print(temp);

opt.argv.remain.forEach( function(x) {
	var json = fs.readFileSync(x)
		, data = JSON.parse(json);
	//print(data);

	var fn = dot.template(temp)
		, render = fn(data);
	print(render);
});
