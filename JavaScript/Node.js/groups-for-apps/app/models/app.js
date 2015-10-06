var mongoose = require("mongoose"),
    Schema = mongoose.Schema,
    relationship = require("mongoose-relationship");

// Load the Group model
var Group = require('./group');

var AppSchema = new Schema({
    name: String,
    groups: [ { type: Schema.ObjectId, ref: "Group" } ]
});

// Expose the model to the app
module.exports = mongoose.model('App', AppSchema);
