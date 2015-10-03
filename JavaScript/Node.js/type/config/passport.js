var LocalStrategy = require('passport-local').Strategy;

// Load the user model
var User = require('../app/models/user');

// Expose the function to the app
module.exports = function(passport) {
  // Passport configuration

  // Session configuration 
  //
  // Passport needs to be able to serialize and unserialize users in the session
  // to support persistent logins

  // Serialize the user in the session
  passport.serializeUser(function(user, done) {
    done(null, user.id);
  });

  // Deserialize the user
  passport.deserializeUser(function(id, done) {
    User.findById(id, function(err, user) {
      done(err, user);
    });
  });

  // Local signup configuration
  //
  // We use named strategies because we have one for signup and one for login. By default,
  // the name is 'local' if a name isn't specified
  passport.use('local-signup', new LocalStrategy({
    // By default, the local strategy uses 'username' and 'password';, we use 'email'
    // instead of 'username'
    usernameField: 'email',
    passwordField: 'password',
    passReqToCallback: true // This allows us to pass the entire request back to the callback
  },
  function(req, email, password, done) {
    // Defer the execution of the callback until the next pass through the event loop -
    // User.findOne won't fire unless data is sent back
    process.nextTick(function() {
      // Find a user whose e-mail address is equal to the e-mail address in the request (to
      // check whether the user who's trying to log in already exists)
      User.findOne({ 'local.email':  email }, function(err, user) {
        // If an error occurs, return it
        if (err) {
          return done(err);
        }

        // Check whether the user who's trying to log in already exists
        if (user) {
          return done(null, false, req.flash('signupMessage', 'A user with that e-mail address already exists'));
        } else {
          // If the user doesn't exist, create a new user...
          var newUser = new User();

          // ...Set its local credentials...
          newUser.local.email = email;
          newUser.local.password = newUser.generateHash(password);

          // ...And save it
          newUser.save(function(err) {
            if (err) {
              throw err;
            }

            return done(null, newUser);
          });
        }
      });    
    });
  }));
};
