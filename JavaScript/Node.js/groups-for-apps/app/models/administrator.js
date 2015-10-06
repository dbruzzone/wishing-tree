var mongoose = require('mongoose'),
    Schema = mongoose.Schema,
    relationship = require('mongoose-relationship');

var password = require("../utils/password");

// The model's schema
var AdministratorSchema = new Schema({
    email: String,
    password: String
});

// Generates a hash
UserSchema.methods.generateHash = password.generateHash; 

// Checks if password is valid
UserSchema.methods.validPassword = password.validPassword;function(password) {

// Expose the model to the app
module.exports = mongoose.model('User', UserSchema);
