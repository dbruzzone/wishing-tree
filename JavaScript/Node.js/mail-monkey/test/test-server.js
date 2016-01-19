var chai = require('chai'),
    chaiHttp = require('chai-http'),
    should = chai.should(),
    server = require('../server');

chai.use(chaiHttp);

describe('The Mail Monkey server', function() {
  // The done argument ends the test case when it's called below
  it('should render its home page', function(done) {
    chai.request(server)
      .get('/')
      .end(function(err, res) {
        res.should.have.status(200);

        res.text.should.equal('<html><head><title>Title</title></head><body><h1>Hello</h1></body></html>');

        done();
    });
  });
});
