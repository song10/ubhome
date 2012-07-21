var addon = require('./build/Release/addon');

var obj1 = addon.createObject('hello');
var obj2 = addon.createObject('world');
console.log(obj1.msg+' '+obj2.msg); // 'hello world'

var fn = addon.createFunction();
console.log(fn()); // 'hello world'
