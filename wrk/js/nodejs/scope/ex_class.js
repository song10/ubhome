//(function () {
	var xxx = {
		varx : "xxx.varx",
		fx : function (that) {
			console.log("1")
			console.log(that)
			console.log("2")
			console.log(this)
			this.fy(this)
		},
		fy : function (that) {
			console.log("3")
			console.log(that)
			console.log("4")
			console.log(this)
		}
	}
	xxx.fx(this);
//}).call(this);
