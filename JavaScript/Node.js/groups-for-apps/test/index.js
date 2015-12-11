var supertest = require("supertest");
var should = require("should");

var server = supertest.agent("http://localhost:3000");

describe("Server", function() {
  it("should successfully retrieve the root route", function(done) {
    server.get("/")
          .expect("Content-type", /json/)
          .expect(200) // The HTTP status code
          .end(function(err, res) {
            // The HTTP status code should be 200
            res.status.should.equal(200);

            // The error key's value should be false
            res.body.error.should.equal(false);

            done();
          });
  });
});
