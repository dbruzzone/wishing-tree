var EmailStrategy = function (strategyName) {
  this.strategy = require(process.cwd() + '/lib/' + strategyName);
}

EmailStrategy.prototype.sendEmail = function () {
  return this.strategy.sendEmail();
};

module.exports = EmailStrategy;
