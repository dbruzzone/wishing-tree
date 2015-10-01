var express = require('express');

var app = express();

app.set('view engine', 'jade');

app.use(express.static('semantic'));

app.get('/', function (req, res) {
  res.render('index', { title: 'A simple typing tutor' });
});

var port = process.env.PORT || 3000;

var server = app.listen(port, function () {
  var serverAddress = server.address();

  console.log('The type app is listening at http://%s:%s', serverAddress.host, serverAddress.port);
});
