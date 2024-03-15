const express = require('express')
const app = express();

const port = 3000;

app.get('/', (req, res) => {
    console.log(req)
res.send("Welcome 2022");
})

app.listen(port,()=>console.log("server running"));

