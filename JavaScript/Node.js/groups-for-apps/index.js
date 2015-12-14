var express = require('express');

var app = express();

var mongoose = require('mongoose');

var morgan = require('morgan');
var bodyParser = require('body-parser');
var jwt = require('jsonwebtoken'); // This is used to create, sign, and verify JSON Web tokens

// Load the app's models
var App = require('./app/models/app');
var Administrator = require('./app/models/administrator');

var password = require("./app/utils/password");

var nconf = require('nconf');

nconf.env().file({ file: 'config.json' });

// App configuration
app.use(morgan('dev')); // Log every request to the console
app.use(bodyParser.json()); // Only parse JSON bodies
app.use(bodyParser.urlencoded({ extended: false }));

app.set('tokenSecret', nconf.get('TOKEN_SECRET')); // Set the app's token secret

// Database configuration
mongoose.connect(nconf.get('MONGO_URI')); // Connect to the database

// Routes
app.get('/', function(req, res) {
    res.json({ "error": false, "message": "Hello!" });
});

app.get('/create-admin', function(req, res) {
  // Create the server's administrator 
  var admin = new Administrator({ 
    email: nconf.get('ADMINISTRATOR_EMAIL'), 
    password: password.generateHash(nconf.get('ADMINISTRATOR_PASSWORD'))
  });

  admin.save(function(err) {
    if (err) throw err;

    console.log("The server's administrator was created successfully");

    res.json({ success: true, 'admin-email': admin.email });
  });
});

// API routes
// TODO 

var port = process.env.PORT || 3000;

var server = app.listen(port, function () {
  var serverAddress = server.address();

  console.log('The groups-for-apps app is listening at http://%s:%s', serverAddress.host, serverAddress.port);
});
