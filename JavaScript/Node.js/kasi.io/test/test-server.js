var chai = require('chai'),
    chaiHttp = require('chai-http'),
    should = chai.should(),
    server = require('../server');

chai.use(chaiHttp);

describe('The kasi.io server', function() {
  // The done argument ends the test case when it's called below
  it('should render its home page', function(done) {
    chai.request(server)
      .get('/')
      .end(function(err, res) {
        res.should.have.status(200);

        res.text.replace(/\s/g, '').should.equal('<html><head><title>kasi.io</title></head><body><h1>Hello</h1></body></html>');

        done();
    });
  });

  it('should render the signup page', function(done) {
    chai.request(server)
      .get('/signup')
      .end(function(err, res) {
        res.should.have.status(200);

        done();
    });
  });

  it('should render the login page', function(done) {
    chai.request(server)
      .get('/login')
      .end(function(err, res) {
        res.should.have.status(200);

        done();
    });
  });
});
