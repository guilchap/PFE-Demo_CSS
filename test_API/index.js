const express = require('express');
const app = express();
const { exec } = require('child_process');
const ipAngers = '172.23.1.64';
const ipDijon = '192.168.56.4';
const port = 8080;

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