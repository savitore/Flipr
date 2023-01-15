import 'dart:convert';

import 'package:flutter/cupertino.dart';
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
            String message=data['message'];
            String error=data['error'];
            print(message);
            print(error);
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
        }catch(e){
            print("Login Error: "+e.toString());
        }
    }

}