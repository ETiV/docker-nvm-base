var express = require('express');
var app = express();

app.get('/', function(req, res){
  res.send('Hello World');
});

app.listen(3000, function(){
  console.log('Server Started ...');
  var i = 0;
  setInterval(function(){
    console.log(i++, 'Server is alive ... to test, run `curl http://127.1:3000/`');
  }, 30 * 1000);
});

