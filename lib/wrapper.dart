import 'package:exchange_app/Home.dart';
import 'package:exchange_app/HomeScreen.dart';
import 'package:exchange_app/Login.dart';
import 'package:exchange_app/addItem.dart';
import 'package:exchange_app/product-detail.dart';
import 'package:exchange_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {

  bool signedIn=false;
  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    _auth.user.listen((User user) {

      if(user == null){
//        print('User is signed out');
        setState(() {
          signedIn = false;
        });
      }
      else{
//        print('User is logged in');
//        print(user);
        setState(() {
          signedIn = true;
        });
      }
    });

    return signedIn?HomeScreen():Login();
  }
}

