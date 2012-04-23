var jade = require('jade');
var fs = require('fs');

var argumentr = require("./argumentr")
var options = {};
argumentr.on("-v","--version","show version information",function() {console.log("version 1.0"); process.exit(0)});
argumentr.on("-t","--template arg","template file name (*.jade)",options);
argumentr.on("-d","--data arg","template data file name (*.json)",options);

var ret = argumentr.parse();
if (! ret.ok) {
	console.log(ret.msg);
	process.exit(-1);
}

//console.log("options hash:")
//console.log(options)

//for (var i = 0; i < argumentr.extra.length; i++) {
//	console.log(argumentr.extra[i])
//};

if (!('template' in options)) {
	console.log('template not specified');
	process.exit(1);
}

var locals = {};
if ('data' in options) {
	jsonstr = fs.readFileSync(options.data);
	//jsonstr = jsonstr.toString();
	//console.log(jsonstr);

	locals = JSON.parse(jsonstr);
	//console.log(JSON.stringify(locals));
	//console.log(locals);
} else {
	//console.log('data not specified');
	//process.exit(1);
}

jadestr = fs.readFileSync(options.template);
//console.log(jadestr);

// Compile a function
options = {}
var fn = jade.compile(jadestr,options);
render = fn(locals);
console.log(render);
