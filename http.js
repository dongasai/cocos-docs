var express = require("express");
var app = express();

app.use(express.static("_book")).listen(8080);
