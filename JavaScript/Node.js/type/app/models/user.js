var mongoose = require('mongoose');
var bcrypt   = require('bcrypt-nodejs');

// The model's schema
var userSchema = mongoose.Schema({
  local: {
    email: String,
    password: String,
  }
});

// Generates a hash
userSchema.methods.generateHash = function(password) {
  return bcrypt.hashSync(password, bcrypt.genSaltSync(8), null);
};

// Checks if password is valid
userSchema.methods.validPassword = function(password) {
  return bcrypt.compareSync(password, this.local.password);
};

// Expose the model to the app
module.exports = mongoose.model('User', userSchema);
