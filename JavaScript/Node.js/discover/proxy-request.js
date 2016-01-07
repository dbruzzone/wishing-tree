var request = require('request');

var req = request.defaults({
  proxy: 'http://localhost:8080'
});

req.get({ url: 'http://www.google.com/' }, function (error, response, user) {
  var errorPrefix = '- Error: ';

  error !== null ? console.log(errorPrefix + error) : console.log(errorPrefix + 'None');

  console.log('- Response: ' + JSON.stringify(response));
  //console.log('- User: ' + user);
});
