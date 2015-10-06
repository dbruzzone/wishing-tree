var express = require('express');

var app = express();

var mongoose = require('mongoose');

var morgan = require('morgan');
var bodyParser = require('body-parser');
var jwt = require('jsonwebtoken'); // This is used to create, sign, and verify JSON Web tokens

var App = require('./app/models/app'); // Load the App model

var nconf = require('nconf');

nconf.env().file({ file: 'config.json' });

// App configuration
app.use(morgan('dev')); // Log every request to the console
app.use(bodyParser.json()); // Only parse JSON bodies
app.use(bodyParser.urlencoded({ extended: false }));

app.set('tokenSecret', nconf.get('TOKEN_SECRET')); // Set the app's token secret

// Database configuration
mongoose.connect(nconf.get('MONGOLAB_URI')); // Connect to the database

// Routes
app.get('/', function(req, res) {
    res.send('Hello. The API is at http://localhost:' + port + '/api');
});

// API routes
// TODO 

var port = process.env.PORT || 3000;

var server = app.listen(port, function () {
  var serverAddress = server.address();

  console.log('The groups-for-apps app is listening at http://%s:%s', serverAddress.host, serverAddress.port);
});
