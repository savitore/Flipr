const http=require('http');
const port=process.env.port||4000;
const app=require('./app');
const server=http.createServer(app);
server.listen(port,(err)=>{
    if(!err)
    console.log('apps are running on localhost:'+port);
    else
    console.log(err);
});