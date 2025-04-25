const express = require("express");
const fs = require("fs");
const path = require("path");

const app = express();
app.get("/", (req, res) => {
  const id = fs.readFileSync("/etc/hostname", "utf8");
  
  // Ler o arquivo environment-info.txt
  const envInfo = fs.readFileSync(path.join(__dirname, 'info', 'environment-info.txt'), 'utf8');

  res.send(`
    <h1>Hello from container ${id}</h1>
    <pre>${envInfo}</pre>  <!-- Exibe o conteúdo do environment-info.txt -->
  `);
});

app.listen(80, () => {
  console.log("App listening on port 80");
});