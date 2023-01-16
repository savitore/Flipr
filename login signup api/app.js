const express =require('express');
const app=express();
const morgan=require('morgan');
const dotenv=require('dotenv').config()
const mongoose=require('mongoose'); 
const bodyParser=require('body-parser');
const userRoutes=require('./apis/routes/user')
// const bseRoutes=require('./apis/routes/BSE');

app.use(morgan('dev'));
app.use(bodyParser.urlencoded({extended:false}));
app.use(bodyParser.json());

mongoose.connect('mongodb+srv://aditya:'+process.env.MONGO_ATLAS_PW+'@cluster0.jkusknw.mongodb.net/?retryWrites=true&w=majority', function(err){
    if(!err) console.log("connected");
    else console.log(err);
});
// app.use('/BSE',bseRoutes);
app.use('/user',userRoutes);

app.use((req,res,next)=>{
    const error=new Error('Not Found');
    error.status=404;
    next(error);
})

app.use((error,req,res,next)=>{
    res.status(error.status||500);
    res.json({
        error:{
            message:error.message
        }
    });
});

module.exports=app;