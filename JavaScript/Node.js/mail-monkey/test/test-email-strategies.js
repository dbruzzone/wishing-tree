var chai = require('chai'),
    expect = chai.expect,
    mockEmailStrategy = require('../lib/mock-email-strategy'),
    mailChimpEmailStrategy = require('../lib/mailchimp-email-strategy'),
    EmailStrategy = require('../lib/email-strategy');

describe('The e-mail strategies', function() {
  describe('E-mail strategy', function() {
    it('should send e-mail', function() {
      var emailStrategy = new EmailStrategy('mock-email-strategy');

      expect(emailStrategy.sendEmail()).to.equal('Mock e-mail strategy');

      var anotherEmailStrategy = new EmailStrategy('mailchimp-email-strategy');

      expect(anotherEmailStrategy.sendEmail()).to.equal('MailChimp e-mail strategy');
    });
  });

  describe('Mock e-mail strategy', function() {
    it('should send e-mail', function() {
      expect(mockEmailStrategy.sendEmail()).to.equal('Mock e-mail strategy');
    });
  });

  describe('The MailChimp e-mail strategy', function() {
    it('should send e-mail', function() {
      expect(mailChimpEmailStrategy.sendEmail()).to.equal('MailChimp e-mail strategy');
    });
  });
});

