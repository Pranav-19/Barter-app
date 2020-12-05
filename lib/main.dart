import 'package:exchange_app/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

      return  MaterialApp(
        debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.blueAccent,
            accentColor: Color.fromRGBO(177, 219, 242, 1.0),
          ),
        home:SafeArea(
          child: Scaffold(
            body: Wrapper(),
          ),
        )
      );
  }
}
