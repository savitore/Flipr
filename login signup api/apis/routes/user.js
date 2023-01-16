const express=require('express');
const router=express.Router();
const mongoose=require('mongoose');
const User=require('../models/user');
const bcrypt=require('bcrypt');
// const express = require('express');
const jwt=require('jsonwebtoken');
const { response } = require('../../app');



router.post('/signup',(req,res,next)=>{
    User.find({email:req.body.email})
    .exec().then(user1=>{
        if(user1.length>=1){
            return res.status(422).json({
                message:'mail exists'
            });
        }else{
            bcrypt.hash(req.body.password,10,(err,hash)=>{
                console.log(hash);
                console.log(req.body.password);
                if(err){
                    console.log(err);
                    return res.status(500).json({
                        error:err
                        
                    });
                    
                }
                else{
                    const user2 =new User({
                        _id:new mongoose.Types.ObjectId(),
                        email:req.body.email,
                        password:hash,
                        name:req.body.name
                        });
                        user2.save(function(err, result){
                            if(!err){
                                console.log(result);
                                res.send(result)
                                return res.status(200).json(result);
                            } 
                            else console.log(err);
                        })
                        
                }
                
                
            });
           
        }
    })
    
});
router.post('/login',(req,res,next)=>{
    User.find({email:req.body.email}).exec()
    .then(user=>{
        if(user.length<1){
            return res.status(401).json({
                message:'Auth failed'
            });
        }bcrypt.compare(req.body.password,user[0].password,(err,result)=>{
            if(err){
                return res.status(401).json({
                    message:'Auth failed'
                });
            }
            if(result){
                console.log(result);
                const token=jwt.sign({
                    email:user[0].email,
                    userId:user[0]._id
                }, process.env.JWT_KEY,
                {
                    expiresIn:"1h"
                },
                );
                console.log(token);
                return res.status(200).json({
                    message:'Auth Successful',
                    token:token
                })
            }
             res.status(401).json({
                message:'Auth failed'
            });
        });
    })
    .catch(err=>{
        console.log(err);
        res.status(500).json({
            error:err
        });
    });
});

module.exports=router;