var dnode = require('dnode');

var server = dnode(function (client) {
    this.calculate = function (n, m, cb) {
        client.div(n*m, function (res) {
            cb(res+1)
        });
    }
});
server.listen(5050);
console.log("listening on port %d in %s mode", 5050, 'server');
