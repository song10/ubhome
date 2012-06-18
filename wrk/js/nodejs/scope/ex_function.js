function fx () {
	console.log(this);
}

function fy (that) {
	console.log("2\n")
	console.log(that);
	var xx = "fy.xx"
	fyx = function (that) {
		console.log("3\n")
		console.log(that);
		console.log("4\n")
		console.log(this);
	}
	fyx(this)
}

function fz (that) {
	console.log("5\n")
	console.log(that);
	fzx = function (that) {
		console.log("6\n")
		console.log(that);
		console.log("7\n")
		console.log(this);
	}
	fzx(this)
}

var mypath = require('path')
//fx()

console.log("1\n")
console.log(this)
fy(this)

fz(this)
