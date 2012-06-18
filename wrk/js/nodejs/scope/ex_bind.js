(function () {
	console.log("1");
	console.log(this);
	var xxx = "xxx"
	yyy = function (that) {
		console.log("2");
		console.log(that)
		console.log("3");
		console.log(this)
		
		var xxx = "xxx"
		zzz = function (that) {
			console.log("4");
			console.log(that)
			console.log("5");
			console.log(this)
		}
		zzz(this)
	}
	yyy(this)
}).call(this);
