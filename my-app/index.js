// index.js
const express = require("express");
const fs = require("fs");

const app = express();
app.get("/", (req, res) => {
  const id = fs.readFileSync("/etc/hostname", "utf8");
  res.send(`<h1>Hello from container ${id}</h1>`);
});

app.listen(80);
