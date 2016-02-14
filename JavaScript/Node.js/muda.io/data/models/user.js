var mongoose = require('mongoose'),
    bcrypt   = require('bcrypt-nodejs');

// The model's schema
var userSchema = mongoose.Schema({
  local: {
    email: String,
    password: String,
  }
});

// Methods
//
// Generates a hash
userSchema.methods.generateHash = function (password) {
  return bcrypt.hashSync(password, bcrypt.genSaltSync(8), null);
};

// Checks if password is valid
userSchema.methods.validPassword = function (password) {
  return bcrypt.compareSync(password, this.local.password);
};

// Export the model
module.exports = mongoose.model('User', userSchema);
