var http = require("http");

// Create an HTTP server
http.createServer(function(request, response) {
  response.writeHead(200, { "Content-Type": "text/plain" });

  response.write("Hello");

  response.end();
}).listen(8888);
