var chai = require('chai'),
    chaiHttp = require('chai-http'),
    should = chai.should(),
    server = require('../index');

chai.use(chaiHttp);

describe('The Type server', function() {
  // The done argument ends the test case when it's called below
  it('should render its home page', function(done) {
    chai.request(server)
      .get('/')
      .end(function(err, res) {
        res.should.have.status(200);

        done();
    });
  });
});
