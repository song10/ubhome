var dnode = require('dnode');

dnode.connect(5050, 'localhost', function (remote) {
    remote.mul(10, 20, function (n) {
        console.log('10 * 20 = ' + n);
    });
});
