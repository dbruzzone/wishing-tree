var chai = require('chai'),
    expect = chai.expect,
    mockEmailStrategy = require('../lib/mock-email-strategy'),
    mailgunEmailStrategy = require('../lib/mailgun-email-strategy'),
    EmailStrategy = require('../lib/email-strategy');

describe('E-mail strategies', function() {
  describe('E-mail strategy', function() {
    it('should send e-mail', function() {
      var emailStrategy = new EmailStrategy('mock-email-strategy');

      expect(emailStrategy.sendEmail()).to.equal('Mock e-mail strategy');

      var anotherEmailStrategy = new EmailStrategy('mailgun-email-strategy');

      expect(anotherEmailStrategy.sendEmail()).to.equal('Mailgun e-mail strategy');
    });
  });

  describe('Mock e-mail strategy', function() {
    it('should send e-mail', function() {
      expect(mockEmailStrategy.sendEmail()).to.equal('Mock e-mail strategy');
    });
  });

  describe('Mailgun e-mail strategy', function() {
    it('should send e-mail', function() {
      expect(mailgunEmailStrategy.sendEmail()).to.equal('Mailgun e-mail strategy');
    });
  });
});

