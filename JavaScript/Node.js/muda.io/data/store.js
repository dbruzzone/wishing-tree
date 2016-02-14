var mongoose = require('mongoose'),
    User = require(__dirname + '/models/user.js');

// I opted for a singleton whose connect method must be called explicitly instead
// of exporting a constructor function to which the data store's URL can be passed
module.exports = {
  connect: function connect(url) {
    mongoose.connect(url);
  },
  User: {
    find: function find(email) {
      // TODO
      console.log("Finding user '" + email + "'");
    }
  }
};
