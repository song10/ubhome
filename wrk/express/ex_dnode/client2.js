var dnode = require('dnode');

var client = dnode({
    div : function (n, cb) {
       cb(n/5);
    }
});

client.connect(5050, function (remote) {
    remote.calculate(10, 20, function (n) {
        console.log('the result is ' + n);
    });
});
