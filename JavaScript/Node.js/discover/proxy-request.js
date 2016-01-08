var fs = require('fs'),
    path = require('path'),
    request = require('request');

var caFile = path.resolve(__dirname, 'ssl/mitmproxy-ca-cert.pem');

var req = request.defaults({
  proxy: 'http://localhost:8080'
});

var options = {
    url: 'https://www.google.com/',
    ca: fs.readFileSync(caFile)
};

req.get(options, function (error, response, user) {
  var errorPrefix = '- Error: ';

  error !== null ? console.log(errorPrefix + error) : console.log(errorPrefix + 'None');

  console.log('- Response: ' + JSON.stringify(response));
  //console.log('- User: ' + user);
});
