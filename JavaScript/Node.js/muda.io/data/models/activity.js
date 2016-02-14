var mongoose = require('mongoose'),
    Schema = mongoose.Schema,
    relationship = require("mongoose-relationship");

// The model's schema
var activitySchema = Schema({
  name: String,
  user: { type: Schema.ObjectId, ref: 'User', childPath: 'activities' },
  periods: [ { type: Schema.ObjectId, ref: 'Period' } ]
});

activitySchema.plugin(relationship, { relationshipPathName: 'user' });

// Export the model
module.exports = mongoose.model('Activity', activitySchema);
