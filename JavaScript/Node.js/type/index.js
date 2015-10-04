var express = require('express');

var app = express();

var mongoose = require('mongoose');
var passport = require('passport');

var morgan = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
var flash = require('connect-flash');
var session = require('express-session');

var nconf = require('nconf');

nconf.env().file({ file: 'config.json' });

// App configuration
app.use(morgan('dev')); // Log every request to the console
app.use(cookieParser()); // Read cookies (Required for authentication)
app.use(bodyParser.json()); // Only parse JSON bodies
app.use(bodyParser.urlencoded({ extended: true }));

app.set('view engine', 'jade');

app.use(express.static('semantic'));

// Database configuration
mongoose.connect(nconf.get('MONGOLAB_URI')); // Connect to the database

// Passport configuration
require('./config/passport')(passport);

app.use(session({ secret: 'haveyoubeenupmywishingtree' })); // Set the session secret
app.use(passport.initialize());
app.use(passport.session()); // Add support for persistent login sessions...
app.use(flash()); // ...And flash messages (which are stored in the session)

// Routes
app.get('/', function (req, res) {
  res.render('index', { title: 'A simple typing tutor' });
});

// Sign up
app.get('/signup', function(req, res) {
  res.render('signup', { title: 'Sign up', message: req.flash('signupMessage') });
});

app.post('/signup', passport.authenticate('local-signup', {
  successRedirect: '/profile', // Redirect the user to their profile page
  failureRedirect: '/signup', // Redirect back to the signup page if an error occurs
  failureFlash: true // Allow flash messages
}));

// Log in
app.get('/login', function(req, res) {
  res.render('login', { title: 'Log in', message: req.flash('loginMessage') }); 
});

app.post('/login', passport.authenticate('local-login', {
  successRedirect: '/profile', // Redirect the user to their profile page
  failureRedirect: '/login', // Redirect back to the login page if an error occurs
  failureFlash: true // Allow flash messages
}));

// Log out
app.get('/logout', function(req, res) {
  req.logout();

  res.redirect('/');
});

// Route middleware that makes sure that users are logged in
function isLoggedIn(req, res, next) {
  // If the user has been authenticated, carry on...
  if (req.isAuthenticated()) {
    return next();
  }

  // ...Otherwise, redirect them to the home page
  res.redirect('/');
}

var port = process.env.PORT || 3000;

var server = app.listen(port, function () {
  var serverAddress = server.address();

  console.log('The type app is listening at http://%s:%s', serverAddress.host, serverAddress.port);
});
