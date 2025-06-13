const http = require('http');
const port = 80;

http.createServer((req, res) => {
  res.writeHead(200, {'Content-Type': 'text/plain'});
  res.end('Hello from priyas gitops project on EC2!\n');
}).listen(port);
