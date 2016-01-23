var chai = require('chai'),
    expect = chai.expect,
    mockEmailStrategy = require('../lib/mock-email-strategy'),
    nodemailerEmailStrategy = require('../lib/nodemailer-email-strategy'),
    EmailStrategy = require('../lib/email-strategy');

describe('E-mail strategies', function() {
  describe('E-mail strategy', function() {
    it('should send e-mail', function() {
      var emailStrategy = new EmailStrategy('mock-email-strategy');

      expect(emailStrategy.sendEmail()).to.equal('Mock e-mail strategy');

      var anotherEmailStrategy = new EmailStrategy('nodemailer-email-strategy');

      expect(anotherEmailStrategy.sendEmail()).to.equal('Nodemailer e-mail strategy');
    });
  });

  describe('Mock e-mail strategy', function() {
    it('should send e-mail', function() {
      expect(mockEmailStrategy.sendEmail()).to.equal('Mock e-mail strategy');
    });
  });

  describe('Nodemailer e-mail strategy', function() {
    it('should send e-mail', function() {
      expect(nodemailerEmailStrategy.sendEmail()).to.equal('Nodemailer e-mail strategy');
    });
  });
});

