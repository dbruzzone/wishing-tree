var mongoose = require('mongoose'),
    Schema = mongoose.Schema,
    relationship = require('mongoose-relationship');

// Load the Group model
var Group = require('./group');

// The model's schema
var UserSchema = new Schema({
    email: String,
    groups: [ { type: Schema.ObjectId, ref: "Group" } ]
});

// Expose the model to the app
module.exports = mongoose.model('User', UserSchema);
