const http=require('http');

const app=require('./app');

const port = process.env.PORT||4000;

const server =http.createServer(app);

server.listen(port , function(err){
    if(!err) console.log("Server is running");
    else console.log(err);
});