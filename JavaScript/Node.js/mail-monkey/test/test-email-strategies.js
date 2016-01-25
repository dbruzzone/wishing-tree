var chai = require('chai'),
    expect = chai.expect,
    EmailStrategy = require('../lib/email-strategy');

describe('E-mail strategies', function() {
  describe('E-mail strategy', function() {
    it('should send e-mail', function() {
      var emailStrategy = new EmailStrategy('mock-email-strategy'),
          response = emailStrategy.sendEmail('davide.bruzzone@gmail.com', 'Test - First', 'Hello from the first e-mail strategy');

      expect(response).to.deep.equal({ status: 'success', recipient: 'davide.bruzzone@gmail.com', subject: 'Test - First' });

      var anotherEmailStrategy = new EmailStrategy('mailgun-email-strategy');

      response = emailStrategy.sendEmail('davide.bruzzone@gmail.com', 'Test - Second', 'Hello from the second e-mail strategy');

      expect(response).to.deep.equal({ status: 'success', recipient: 'davide.bruzzone@gmail.com', subject: 'Test - Second' });;
    });
  });
});

