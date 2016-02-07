var fs = require('fs'),
    nconf = require('nconf'),
    nunjucks = require('nunjucks');

nconf.env().file({ file: 'config.json' });

var express = require('express');

var app = express();

var morgan = require('morgan');
var bodyParser = require('body-parser');

// App configuration
app.use(morgan('dev')); // Log every request to the console

app.use(bodyParser.urlencoded({ extended: false })); // Handle 'application/x-www-form-urlencoded' forms

nunjucks.configure(nconf.get('views'), {
  express: app
});

app.use(express.static('semantic'));

// Routes
app.get('/', function (req, res) {
  res.render('index.html');
});

app.get('/signup', function (req, res) {
  res.render('signup.html');
});

app.get('/login', function (req, res) {
  res.render('login.html');
});

var port = nconf.get('port') || 3000;

var server = app.listen(port, function () {
  var serverAddress = server.address();

  console.log('The kasi.io app is listening at http://%s:%s', serverAddress.host, serverAddress.port);
});

module.exports = app;
