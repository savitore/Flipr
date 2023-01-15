import 'dart:convert';

import 'package:flipr/authentication/login.dart';
import 'package:flipr/market/NSE.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class AuthService{
  Future RegisterWithNameEmailPassword(String name,String email,String password,BuildContext context) async{
    String baseURL='https://authapi-bk7v.onrender.com/user/signup';
    final body={
      "email":email,
      "password":password,
      "name":name
    };
    final response;
    try{
      response=await http.post(Uri.parse(baseURL),
          headers:{'Content-type': 'application/json'},
          body: jsonEncode(body)
      );
      var data=jsonDecode(response.body);
      print(data);
      Navigator.pop(context);
      String message=data['message'].toString();
      String error=data['error'].toString();
      print("message"+message);
      print("error"+error);
      if(message=='mail exists'){
        // Alert to show email exists.
        showDialog(context: context, builder: (context)=>AlertDialog(
          content: Text(
              'Mail Exists'
          ),
        ));
      }
      if(message=='null'){
        //Go to login
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => NSE()),
                (route) => false);
      }
      if(error!='null'){
        // Alert to show unsuccessful registeration
        showDialog(context: context, builder: (context)=>AlertDialog(
          title: Text(
            'Authentication Message',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
              'Registration UnSuccessful! Retry Later'
          ),
        ));
      }
    }catch(e){
      print("Register Error: "+e.toString());
    }
  }

  Future LoginWithEmailPassword(String email,String password,BuildContext context) async{
    String baseURL='https://authapi-bk7v.onrender.com/user/login';
    final body={
      "email":email,
      "password":password
    };
    final response;
    try{
      response=await http.post(Uri.parse(baseURL),
          headers:{'Content-type': 'application/json'},
          body: jsonEncode(body)
      );
      var data=jsonDecode(response.body);
      print(data);
      Navigator.pop(context);
      String message=data['message'];
      print(message);
      if(message=='Auth Successful'){
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => NSE()),
                (route) => false);
      }
      if(message=='Auth failed'){
        showDialog(context: context, builder: (context)=>
            AlertDialog(
            //  title: Text(
            // 'Authentication Message',
            // style: TextStyle(
            //   color: Colors.black,
            //   fontWeight: FontWeight.bold,
            // ),
            // ),
            content: Text(
              'Incorrect email or password'
          ),
        ));
      }
    }catch(e){
      print("Login Error: "+e.toString());
    }
  }
  void showToast() =>
      Fluttertoast.showToast(
          msg: "Incorrect email or password.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0
      );
}