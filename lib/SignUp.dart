import 'package:exchange_app/Home.dart';
import 'package:exchange_app/loading.dart';
import 'package:exchange_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:exchange_app/services/auth.dart';
import 'Login.dart';
import 'package:email_validator/email_validator.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {


  final myFormKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  String email='',password='',repeatPassword='',name='',phoneNo='';
  bool loading=false;


  @override
  Widget build(BuildContext context) {
    return loading?Loading():Scaffold(
        body: Container(
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
              image:  DecorationImage(
            image: AssetImage("images/bg_img.jpg"),
            fit: BoxFit.cover,
               ),
            ),
          padding: EdgeInsets.only(top: 25),
          
          child: Form(
            
            key: myFormKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 20),
                child: Column(     
                children: [
                  SizedBox(
                    height: 100,
                  ),
                    Text("Please enter the following details",
                      style: TextStyle(fontSize: 21,color: Colors.white,fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 50,
                  ),
                     Container(
                    margin: EdgeInsets.all(12),
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        labelText: 'Name',
                         labelStyle:TextStyle(fontSize: 20,fontStyle: FontStyle.italic) ,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 2,
                          ),
                        ),
                      ),
                      textCapitalization: TextCapitalization.words,
                      onChanged: (val){
                        setState(() {
                          name = val;
                        });
                      },
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.all(12),
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        labelText: 'Email',
                         labelStyle:TextStyle(fontSize: 20,fontStyle: FontStyle.italic) ,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 2,
                          ),
                        ),
                      ),
                      onChanged: (val){
                        setState(() {
                          email = val;
                        });
                      },
                      validator: (val){
                        return EmailValidator.validate(val)?null:'Enter a valid email';
                      },
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),

                   Container(
                    margin: EdgeInsets.all(12),
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        labelText: 'Phone Number',
                         labelStyle:TextStyle(fontSize: 20,fontStyle: FontStyle.italic) ,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 2,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                      onChanged: (val){
                        phoneNo = val;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(12),
                    child: TextFormField(                                          
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        labelText: 'Password',
                        labelStyle:TextStyle(fontSize: 20,fontStyle: FontStyle.italic) ,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 2,
                          ),
                        ),
                      ),

                      onChanged: (val){
                        setState(() {
                          password = val;
                        });
                      },
                      obscureText: true,
                      validator: (val){
                        return val.length<6?'Password should be of 6 or more chars':null;
                      },
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.all(12),
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        labelText: 'Repeat Password',
                         labelStyle:TextStyle(fontSize: 20,fontStyle: FontStyle.italic) ,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 2,
                          ),
                        ),
                      ),
                      onChanged: (val){
                        setState(() {
                          repeatPassword = val;
                        });
                      },
                      obscureText: true,
                      validator: (val){
                        return password==repeatPassword?null:'Passwords do not match';
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(15),
                    width: 180,
                    child: MaterialButton(
                      color: Color.fromRGBO(90, 56, 167,1.0),
                      shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(23.0),
                        side: BorderSide(color: Color.fromRGBO(213, 196, 105,1.0),
                        width: 1.5),                    
                      ),
                      
                      textColor: Theme.of(context).scaffoldBackgroundColor,
                      child: Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 21,color: Color.fromRGBO(213, 196, 105,1.0)),
                      ),
                      elevation: 4,
                      onPressed: () async{
                        if(myFormKey.currentState.validate()){
                          setState(() {
                            loading = true;
                          });
                          User user = await _auth.register(email, password);
                          print(user);
                          if(user == null){
                            setState(() {
                              loading = false;
                            });
                          }
                          else{
                            DatabaseService db = DatabaseService(uid: user.uid);
                            await db.setUserData(name,phoneNo);
                            Navigator.pop(context);
                          }

                        }

                      },
                      height: 45,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),                    
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Already have an account? ",
                      style: TextStyle(fontSize: 21,color: Colors.white,fontWeight: FontWeight.bold),),
                      FlatButton(
                       onPressed: (){
                      Navigator.pop(context);
                      },
                        child: Text
                        ('Login',style: TextStyle(fontSize: 21, color: Colors.white, fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline, fontStyle: FontStyle.italic)),
                      )
                  ],)
                ],
              ),
            ),
          ),
        ),
    );
  }
  
}