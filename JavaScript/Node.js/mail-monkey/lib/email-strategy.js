var EmailStrategy = function (strategyName) {
  this.strategy = require(process.cwd() + '/lib/' + strategyName);
}

EmailStrategy.prototype.sendEmail = function (recipient, subject, message) {
  return this.strategy.sendEmail(recipient, subject, message);
};

module.exports = EmailStrategy;
