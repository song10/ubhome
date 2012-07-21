var addon = require('./build/Release/addon');

addon.runCallback(function(msg){
	  console.log(msg); // 'hello world'
  });
