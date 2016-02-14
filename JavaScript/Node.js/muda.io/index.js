'use strict';

var fs = require('fs'),
    nconf = require('nconf'),
    store = require(__dirname + '/data/store.js'),
    apiRoutes = require(__dirname + '/routes/api.js');

nconf.env().file({ file: 'config.json' });

var express = require('express');

var app = express();

var morgan = require('morgan');
var bodyParser = require('body-parser');

// App configuration
app.use(morgan('dev')); // Log every request to the console

app.use(bodyParser.json()); // Parse 'application/json' requests
app.use(bodyParser.urlencoded({ extended: false })); // Parse 'application/x-www-form-urlencoded' requests

// Data store
store.connect(nconf.get('data-store:url'))

// Routes
app.use('/api', apiRoutes);

var port = nconf.get('port') || 3000;

var server = app.listen(port, function () {
  var serverAddress = server.address();

  console.log('The muda.io app is listening at http://%s:%s', serverAddress.host, serverAddress.port);
});

module.exports = app;
