var mongoose = require('mongoose'),
    Schema = mongoose.Schema,
    bcrypt   = require('bcrypt-nodejs');

// The model's schema
var userSchema = Schema({
  local: {
    email: String,
    password: String,
  },
  activities: [ { type: Schema.ObjectId, ref: 'Activity' }]
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
