var express = require('express');
var app = express();

app.get('/', function(req, res){
  res.send('Hello World');
});

app.listen(3000, function(){
  console.log('Server Started ... Access through: http://127.0.0.1:3000/');
  console.log('Node.js Version:', process.version);
  var i = 0;
  setInterval(function(){
    console.log(i++, 'Server is alive ... to test, run `curl http://127.1:3000/`');
  }, 30 * 1000);
});

