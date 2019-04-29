const csv = require("csv-parser");
const fs = require("fs");
const path = require("path");
const YAML = require('yaml');

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
  const profile = (await parseCSV("Profile.csv"))[0];
  const education = await parseCSV("Education.csv");
  const experience = positions.map(p => ({
    dates: `${p["Started On"]} - ${p["Finished On"] || "Current"}`,
    employer: p["Company Name"],
    title: p["Title"],
    city: p["Location"],
    description: p["Description"].split("● ").filter(x => x)
  }));

  const certifications = education.map(e => ({
    cert: e["Degree Name"],
    description: `${e["Start Date"]} - ${e["End Date"]} at ${e["School Name"]}`
  }));

  const result = {
    mainfont: "Helvetica",
    firstname: profile["First Name"],
    lastname: profile["Last Name"],
    email: "dane@lipscombe.com.au",
    linkedin: "danelipscombe",
    github: "dlip",
    twitter: "danelips",
    homepage: "http://lipscombe.com.au/",
    summary: profile["Summary"],
    experience,
    certifications
  };
  console.log(YAML.stringify(result));
  fs.writeFileSync("resume.yml", "---\n" + YAML.stringify(result) + "\n...")
}
run();

