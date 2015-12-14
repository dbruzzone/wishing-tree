var mongoose = require('mongoose'),
    Schema = mongoose.Schema,
    relationship = require('mongoose-relationship');

var password = require("../utils/password");

// The model's schema
var AdministratorSchema = new Schema({
    email: String,
    password: String
});

// Generates a password hash
AdministratorSchema.methods.generateHash = password.generateHash; 

// Checks if password is valid
AdministratorSchema.methods.validPassword = password.validPassword;

// Expose the model to the app
module.exports = mongoose.model('Administrator', AdministratorSchema);
