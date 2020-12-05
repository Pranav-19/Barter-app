
import 'package:exchange_app/models/product.dart';
import 'package:exchange_app/services/auth.dart';
import 'package:exchange_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>_HomeState();
}

class _HomeState extends State<Home>{

  final AuthService _auth = AuthService();
  final DatabaseService _database = DatabaseService(uid: FirebaseAuth.instance.currentUser.uid);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
       child:Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black,width: 1.5),
                borderRadius: BorderRadius.circular(18),
                color: Color.fromRGBO(155, 201, 255, 1.0)
              ),
              child: Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 15,),
                    Text('Welcome, what do you want?',
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 30),
                    Container(
                      padding: EdgeInsets.all(10),
                      child:TextField(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                          labelText: 'Search...',
                          labelStyle:TextStyle(fontSize: 20,fontStyle: FontStyle.italic) ,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25))
                      ),
                    ) ,
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ), 
            ),
            SizedBox(
              height: 30,
            ),
            Text('Suggested items',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 23)),
             SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black,width: 1.5),
                borderRadius: BorderRadius.circular(23),
                color: Color.fromRGBO(155, 201, 255, 1.0)
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('images/img1.jpg'),

                  ),
                  SizedBox(width: 20,),
                  Column(
                    children: <Widget>[
                      Text('Xbox 360',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 21),),
                      Text('1.5 years old',
                      style: TextStyle(color: Colors.black87, fontSize: 17))
                    ],
                  )
                ],
                ),
              ),
              SizedBox(height: 15),
           Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black,width: 1.5),
                borderRadius: BorderRadius.circular(23),
                color: Color.fromRGBO(155, 201, 255, 1.0)
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('images/img1.jpg'),

                  ),
                  SizedBox(width: 20,),
                  Column(
                    children: <Widget>[
                      Text('Xbox 360',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 21),),
                      Text('1.5 years old',
                      style: TextStyle(color: Colors.black87, fontSize: 17))
                    ],
                  )
                ],
                ),
              ),
              SizedBox(height: 15),
           Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black,width: 1.5),
                borderRadius: BorderRadius.circular(23),
                color: Color.fromRGBO(155, 201, 255, 1.0)
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('images/img1.jpg'),

                  ),
                  SizedBox(width: 20,),
                  Column(
                    children: <Widget>[
                      Text('Xbox 360',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 21),),
                      Text('1.5 years old',
                      style: TextStyle(color: Colors.black87, fontSize: 17))
                    ],
                  )
                ],
                ),
              ),
              SizedBox(height: 15),
           Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black,width: 1.5),
                borderRadius: BorderRadius.circular(23),
                color: Color.fromRGBO(155, 201, 255, 1.0)
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('images/img1.jpg'),

                  ),
                  SizedBox(width: 20,),
                  Column(
                    children: <Widget>[
                      Text('Xbox 360',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 21),),
                      Text('1.5 years old',
                      style: TextStyle(color: Colors.black87, fontSize: 17))
                    ],
                  )
                ],
                ),
              ),
              SizedBox(height: 15),
              RaisedButton(onPressed: () async {
               final products = await _database.allProducts;
               for(final p in products){
                 print('${p.name} ${p.description} ${p.years} ${p.months} ${p.imgUrl}');
               }
            },
            child: Text('Fetch data'),
            ),
            RaisedButton(onPressed: () async{
              await _auth.signout();
            },
            child: Text('Sign out'),
            )

          ],
        )
        ),
      )
    );
  }
  
}