var http = require('http');
http.createServer(function (req, res) {
  res.writeHead(200, {'Content-Type': 'text/plain'});
  res.end('Hello World\n');
//}).listen(1337, '192.168.128.2');
}).listen(8000);
console.log('Server running at http://192.168.128.2:1337/');
