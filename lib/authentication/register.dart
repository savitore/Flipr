import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var name="",email="",password="",confirm="";
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back,color: Colors.white,),
        ),
      ),
      backgroundColor: Colors.blue[400],
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 30, 40, 20),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Text('Sign Up',style: TextStyle(color: Colors.white,fontSize: 25),),
                SizedBox(height: 30,),
                TextFormField(
                  validator: (val)=> val!.isEmpty? 'Enter your name':null,
                    keyboardType: TextInputType.name,
                    onChanged: (value){
                    name=value;
                    },
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.grey[300]),
                      filled: true,
                    fillColor: Colors.blue[300],
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    hintText: "Enter Your Name"
                ),
              ),
                SizedBox(height: 20,),
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
                  validator: (val)=> val!.length<6? 'Password should be atleast 6 characters':null,
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
                SizedBox(height: 20,),
                TextFormField(
                  obscureText: true,
                  validator: (val)=> val!=password? 'Password do not match':null,
                  keyboardType: TextInputType.text,
                  onChanged: (value){
                    confirm=value;
                  },
                  decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.grey[300]),
                      filled: true,
                      fillColor: Colors.blue[300],
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      hintText: "Confirm Password"
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
                        //logic
                      }
                    },
                    child: Text('REGISTER',style: TextStyle(color: Colors.blue,fontSize: 17),),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                  ),
                ),
                SizedBox(height: 20,),
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Have an account?',style: TextStyle(color: Colors.white,fontSize: 17),),
                      Text('Sign in',style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
