var EmailStrategy = function (strategy) {
  this.strategy = strategy;
}

EmailStrategy.prototype.sendEmail = function () {
  return this.strategy.sendEmail();
};

module.exports = EmailStrategy;
