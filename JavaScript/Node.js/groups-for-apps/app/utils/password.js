// Generates a hash
module.exports.generateHash = function(password) {
  return bcrypt.hashSync(password, bcrypt.genSaltSync(8), null);
};

// Checks if password is valid
module.exports.validPassword = function(password) {
  return bcrypt.compareSync(password, this.local.password);
};
