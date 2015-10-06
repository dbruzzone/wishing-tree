var mongoose = require('mongoose'),
    Schema = mongoose.Schema,
    relationship = require('mongoose-relationship');

// Load the App and User models
var App = require('./app');
var User = require('./user');

var GroupSchema = new Schema({
    name: String,
    apps: [ { type: Schema.ObjectId, ref: 'App', childPath: 'groups' } ],
    users: [ { type: Schema.ObjectId, ref: 'User', childPath: 'groups' } ]
});

GroupSchema.plugin(relationship, { relationshipPathName: [ 'apps', 'users' ] });

// Expose the model to the app
module.exports = mongoose.model('Group', GroupSchema);
