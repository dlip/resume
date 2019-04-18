const csv = require("csv-parser");
const fs = require("fs");
const path = require("path");

let importPath = "linkedin-export";

function parseCSV(filename) {
  return new Promise((resolve, reject) => {
    const result = [];
    fs.createReadStream(path.join(importPath, filename))
      .pipe(csv())
      .on("data", data => result.push(data))
      .on("end", () => {
        resolve(result);
      });
  });
}

async function run() {
  const positions = await parseCSV("Positions.csv");
  const result = {
    positions
  };
  console.log(JSON.stringify(result));
}
run();

