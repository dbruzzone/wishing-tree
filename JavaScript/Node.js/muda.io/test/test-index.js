var chai = require('chai'),
    chaiHttp = require('chai-http'),
    should = chai.should(),
    server = require('../index');

chai.use(chaiHttp);

describe('The muda.io server', function () {
  describe('API', function () {
    // The done argument ends the test case when it's called below
    it('should respond to a request for the root route', function (done) {
      chai.request(server)
          .get('/api/')
          .end(function (err, res) {
            res.should.be.json;

            res.text.replace(/\s/g, '').should.equal('{"message":"Hello."}');

            done();
      });
    });
  });
});
