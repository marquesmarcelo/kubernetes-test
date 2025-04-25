const express = require("express");
const fs = require("fs");
const path = require("path");

const app = express();
app.get("/", (req, res) => {
  const id = fs.readFileSync("/etc/hostname", "utf8");
  
  // Ler o arquivo Chart.yaml
  const chartInfo = fs.readFileSync(path.join(__dirname, 'info', '/app/info/Chart.yaml'), 'utf8');

  res.send(`
    <h1>Hello from container ${id}</h1>
    <pre>${chartInfo}</pre>  <!-- Exibe o conteúdo do Chart.yaml -->
  `);
});

app.listen(80, () => {
  console.log("App listening on port 80");
});
