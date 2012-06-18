(function () {
	_ = this;
	var x = "x"
	_.path = require('path')
	console.log(this);
	//	test(_)
	//var fx = function (that) {
	_.fx = function (that) {
		console.log(that);
		console.log(this);
	}
	//fx(_)
	_.fx(_)
}).call(this)

function test (that) {
	console.log(that);
	console.log(this);
}
