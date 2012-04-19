fs = require('fs')
require.extensions[".json"] = function (m) {
 m.exports = JSON.parse(fs.readFileSync(m.filename));
};
var xxx = require('./cfg.json');
console.log(xxx.twit.consumerKey);
