var chai = require('chai'),
    expect = chai.expect,
    mockEmailStrategy = require('../lib/mock-email-strategy'),
    mailChimpEmailStrategy = require('../lib/mailchimp-email-strategy');
    

describe('The e-mail strategies', function() {
  describe('Mock e-mail strategy', function() {
    it('should send e-mail', function() {
      console.log('Result: ' + JSON.stringify(mockEmailStrategy));

      expect(mockEmailStrategy.sendEmail()).to.equal('Mock e-mail strategy');
    });
  });

  describe('The MailChimp e-mail strategy', function() {
    it('should send e-mail', function() {
      expect(mailChimpEmailStrategy.sendEmail()).to.equal('MailChimp e-mail strategy');
    });
  });
});

