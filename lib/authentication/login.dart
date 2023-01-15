import 'package:flipr/authentication/register.dart';
import 'package:flipr/services/auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var email="",password="";
  var formKey = GlobalKey<FormState>();
  AuthService authService=AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[400],
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 100, 40, 20),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Text('Sign In',style: TextStyle(color: Colors.white,fontSize: 25),),
                SizedBox(height: 30,),
                TextFormField(
                  validator: (val)=> val!.isEmpty? 'Enter your email':null,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value){
                    email=value;
                  },
                  decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.grey[300]),
                      filled: true,
                      fillColor: Colors.blue[300],
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      hintText: "Enter Your Email"
                  ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  onChanged: (value){
                    password=value;
                  },
                  decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.grey[300]),
                      filled: true,
                      fillColor: Colors.blue[300],
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      hintText: "Enter Your Password"
                  ),
                ),
                SizedBox(height: 40,),
                SizedBox(
                  height: 45,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if(formKey.currentState!.validate()){
                        showLoaderDialog(BuildContext context){
                          AlertDialog alert = AlertDialog(
                            content: new Row(
                              children: [
                                CircularProgressIndicator(),
                                Container(margin: EdgeInsets.only(left: 7),child: Text("Loading..."),)
                              ],
                            ),
                          );
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context){
                                return alert;
                              }
                          );
                        }
                        showLoaderDialog(context);
                        authService.LoginWithEmailPassword(email, password, context);
                        //logic
                      }
                    },
                    child: Text('LOGIN',style: TextStyle(color: Colors.blue,fontSize: 17),),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                  ),
                ),
                SizedBox(height: 20,),
                InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context)=> Register()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Do not have an account?',style: TextStyle(color: Colors.white,fontSize: 17),),
                      Text('Sign up',style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );;
  }
}