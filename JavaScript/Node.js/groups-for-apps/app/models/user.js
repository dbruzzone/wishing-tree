var bcrypt = require('bcrypt-nodejs')
    mongoose = require('mongoose'),
    Schema = mongoose.Schema,
    relationship = require('mongoose-relationship');

// Load the Group model
var Group = require('./group');

// The model's schema
var UserSchema = new Schema({
    email: String,
    groups: [ { type: Schema.ObjectId, ref: "Group" } ]
});

// Generates a hash
UserSchema.methods.generateHash = function(password) {
  return bcrypt.hashSync(password, bcrypt.genSaltSync(8), null);
};

// Checks if password is valid
UserSchema.methods.validPassword = function(password) {
  return bcrypt.compareSync(password, this.local.password);
};

// Expose the model to the app
module.exports = mongoose.model('User', UserSchema);
