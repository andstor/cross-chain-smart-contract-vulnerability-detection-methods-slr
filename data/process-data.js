var bibtexParse = require('@orcid/bibtex-parse-js');
var fs = require('fs');
const fastcsv = require("fast-csv");
const csv = require('csv-parser');


let records = [];
fs.createReadStream(__dirname + '/web-of-science.csv', 'utf-8')
    .pipe(csv({separator: ';'}))
    .on('data', (data) => {
        records.push(data);
    })
    .on('end', () => {
        console.log("Total records: " + records.length);
        processPublicationYear()
        processPublicationType();
    });


    
    
    
    function processPublicationYear() {
        // Type of publication by year
        
        let publication_year = new Map();
        records.forEach(function (record) {
            let year = record['Publication Year'];
            publication_year.set(year, publication_year.get(year) + 1 || 1);
        });
        
        let result = [Object.fromEntries(publication_year)];
        console.log(result)
        fastcsv
        .write(result, { headers: true })
        .on("finish", function () {
            console.log("Write to CSV successfully!");
        })
        .pipe(fs.createWriteStream(__dirname + "/publication-year.csv"));
    }
    
    function processPublicationType() {
        // Type of publication by year
    
        let type_by_year = new Map();
        records.forEach(function (record) {
            let year = record['Publication Year'];
            let type = record['Document Type'];

            let colName = year + " " + type;
            type_by_year.set(colName, type_by_year.get(colName) + 1 || 1);
        });
    
        let result = [Object.fromEntries(type_by_year)];
        fastcsv
            .write(result, { headers: true })
            .on("finish", function () {
                console.log("Write to CSV successfully!");
            })
            .pipe(fs.createWriteStream(__dirname + "/publication-type.csv"));
    }
    

