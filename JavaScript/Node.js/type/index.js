var express = require('express');

var app = express();

app.set('view engine', 'jade');

app.get('/', function (req, res) {
  res.render('index', { title: 'A simple typing tutor', message: 'Hello.' });
});

var server = app.listen(3000, function () {
  var host = server.address().address;
  var port = server.address().port;

  console.log('The type app is listening at http://%s:%s', host, port);
});
