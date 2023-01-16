const express=require("express");
const bodyParser=require("body-parser");
const mongoose=require("mongoose");
const app=express();
app.use(bodyParser.urlencoded({extended: true}));
//
const uri="mongodb+srv://SatwikMohan:Captain47.@cluster0.m74pkly.mongodb.net/DB?retryWrites=true&w=majority";
mongoose.connect(
    uri,
    { useNewUrlParser: true, useUnifiedTopology: true },
    (err) => {
        if(!err) console.log(" Mongoose is connected");
        else console.log(err);
    }
  );
mongoose.set('strictQuery', false);

mongoose.pluralize(null);
const ac="Adj Close";
const schema={
    Date:String,
    Open:Number,
    High:Number,
    Low:Number,
    Close:Number,
    ac:Number,
    Volume:Number
};

//Collection
//const User=mongoose.model("User",schema);
const Reliance=mongoose.model("Reliance",schema);
const Cipla=mongoose.model("Cipla",schema);
const AshokLey=mongoose.model("AshokLey",schema);
const TataSteel=mongoose.model("TataSteel",schema);
const EicherMotor=mongoose.model("EicherMotor",schema);
const NSE=mongoose.model("NSE",schema);
const BSE=mongoose.model("BSE",schema);

//for insert
// const Rahul=User({
//     name:"Rahul",
//     age:20
// });
// Rahul.save(function(e){
//     if(!e){
//         console.log("Rahul is Saved");
//     }
// });


app.get("/:company",function(request,response){
    const companyName=request.params.company;
    console.log(companyName);
    if(companyName=="Reliance"){
        Reliance.find({},function(err,result){
            if(!err){
                response.send(result);  
            }else{
                console.log(err);
                response.send(err);
            }
        });
    }
    if(companyName=="Cipla"){
        Cipla.find({},function(err,result){
            if(!err){
                response.send(result);  
            }else{
                console.log(err);
                response.send(err);
            }
        });
    }
    if(companyName=="AshokLey"){
        AshokLey.find({},function(err,result){
            if(!err){
                response.send(result);  
            }else{
                console.log(err);
                response.send(err);
            }
        });
    }
    if(companyName=="TataSteel"){
        TataSteel.find({},function(err,result){
            if(!err){
                response.send(result);  
            }else{
                console.log(err);
                response.send(err);
            }
        });
    }
    if(companyName=="EicherMotor"){
        EicherMotor.find({},function(err,result){
            if(!err){
                response.send(result);  
            }else{
                console.log(err);
                response.send(err);
            }
        });
    }
    if(companyName=="NSE"){
        NSE.find({},function(err,result){
            if(!err){
                response.send(result);  
            }else{
                console.log(err);
                response.send(err);
            }
        });
    }
    if(companyName=="BSE"){
        BSE.find({},function(err,result){
            if(!err){
                response.send(result);  
            }else{
                console.log(err);
                response.send(err);
            }
        });
    }
});

app.listen(3000,function(err){
    if(!err) console.log("Server is running");
});
