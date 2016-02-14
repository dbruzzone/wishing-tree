var mongoose = require('mongoose'),
    Schema = mongoose.Schema,
    relationship = require("mongoose-relationship");

// The model's schema
var periodSchema = Schema({
  activity: { type: Schema.ObjectId, ref: 'Activity', childPath: 'periods' },
  start: Date,
  end: Date
});

periodSchema.plugin(relationship, { relationshipPathName: 'activity' });

// Export the model
module.exports = mongoose.model('Period', periodSchema);
