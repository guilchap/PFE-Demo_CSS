const express = require('express');
const cors = require('cors');
const { exec } = require('child_process');

const app = express();
const ipAngers = '172.23.1.64';
const ipDijon = '192.168.56.4';
const port = 8080;

app.get('/',(req,res)=>{
  res.set('Access-Control-Allow-Origin', '*');
})

// app.use(cors())

// app.get('/', function (req, res, next) {
//   res.json({msg: 'This is CORS-enabled for all origins!'})
// })

// app.use(function (res) {

//   res.setHeader('Access-Control-Allow-Origin', '*');
//   res.json();

//   //Request methods you wish to allow
//   res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE');

//   // Request headers you wish to allow
//   res.setHeader('Access-Control-Allow-Headers', 'X-Requested-With,content-type');

//   // Set to true if you need the website to include cookies in the requests sent
//   // to the API (e.g. in case you use sessions)
//   res.setHeader('Access-Control-Allow-Credentials', true);

//   // Pass to next layer of middleware
//   res.send('cors problem fixed:)');

//   logger.debug('Calling res.send');
// });

console.log('hello console');

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

require('http').createServer(function(req, res) {
    res.writeHead(200, {'Content-Type': 'text/html'});
    res.end('' +
`<html>
  <head></head>
  <body>
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