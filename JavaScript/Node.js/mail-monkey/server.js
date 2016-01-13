var fs = require('fs'),
    nconf = require('nconf');

nconf.env().file({ file: 'config.json' });

var express = require('express');

var app = express();

var morgan = require('morgan');
var bodyParser = require('body-parser');

// App configuration
app.use(morgan('dev')); // Log every request to the console

app.use(bodyParser.urlencoded({ extended: false })); // Handle 'application/x-www-form-urlencoded' forms

// Routes
app.get('/', function (req, res) {
  // TODO
  res.send('Hello');
});

var port = nconf.get('port') || 3000;

var server = app.listen(port, function () {
  var serverAddress = server.address();

  console.log('The mail-monkey app is listening at http://%s:%s', serverAddress.host, serverAddress.port);
});

module.exports = app;
