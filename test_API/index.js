const express = require('express');
const app = express();
const { exec } = require('child_process');
const ipAngers = '172.23.1.64';
const ipDijon = '192.168.56.4';
const port = 8080;

const http = require('http');
const httpServer = http.createServer();

// Mes origines acceptées
const allowOrigins = ['http://localhost:4200'];

httpServer.on('request', (request, response) => {

    // On test si l'entête "Origin" fait partie des origines acceptées
    if (request.headers['origin'] && allowOrigins.includes(request.headers['origin'])) {

        // Si oui alors on renseigne "Access-Control-Allow-Origin" avec l'origine de la requête
        response.setHeader('Access-Control-Allow-Origin', request.headers['origin']);
    } else {

        // Sinon on renseigne "Access-Control-Allow-Origin" à null créant une erreur CORS dans le navigateur
        response.setHeader('Access-Control-Allow-Origin', 'null');
    }

    if (request.method === 'OPTIONS') {
        response.setHeader('Access-Control-Allow-Headers', 'Content-Type, Accept, Origin, Authorization');
        response.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, PATCH, OPTIONS');

        return response.end();
    }

    // suite du traitement ...
});

console.log('hello console');

// exec("dir", (error, stdout, stderr) => {
//     if (error) {
//         console.log(`${error.message}`);
//         return;
//     }
//     if (stderr) {
//         console.log(`${stderr}`);
//         return;
//     }
//     console.log(`${stdout}`);
// });

// exec(`ping ${ipDijon}`, (error, stdout, stderr) => {
//     if (error) {
//         console.log(`${error.message}`);
//         return;
//     }
//     if (stderr) {
//         console.log(`${stderr}`);
//         return;
//     }
//     console.log(`${stdout}`);
// });

// exec(`ping ${ipAngers}`, (error, stdout, stderr) => {
//     if (error) {
//         console.log(`${error.message}`);
//         return;
//     }
//     if (stderr) {
//         console.log(`${stderr}`);
//         return;
//     }
//     console.log(`${stdout}`);
// });

// app.get('/', (req, res) => {
//     res.send('Hello');
// })

// app.listen(`${port}`, () => {  
//     console.log(`Serveur à l écoute sur ${port}`);     
// })

require('http').createServer(function(req, res) {
    res.writeHead(200, {'Content-Type': 'text/html'});
    res.end('' +
`<html>
  <head></head>
  <body>
    Hello
    <script>
      /********** Browser start ********/
      /* This code is run in the browser */
      console.log('print in browser console ');
      /********** Browser end ********/
    </script>
  </body>
</html>`);
    console.log('print in Node.js engine');   
}).listen(8080);