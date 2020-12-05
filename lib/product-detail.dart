import 'package:flutter/material.dart';
import 'package:exchange_app/models/product.dart';
import 'package:exchange_app/models/user.dart';
import 'package:exchange_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Detail extends StatefulWidget {

  final Product product;
  Detail({this.product});
  @override
  _Detail createState() => _Detail(product:this.product);
}

class _Detail extends State<Detail> {
  Product product;
  AppUser productOwner;
  bool isLoading = false;
  DatabaseService _database = DatabaseService(uid: FirebaseAuth.instance.currentUser.uid);
  
  _Detail({this.product});

  @override
  void initState() {
    super.initState();
    this.fetchUser();
    
  }

  Future fetchUser() async{
    try{
      setState(() {
        isLoading = true;
      });
      productOwner = await _database.getProductOwner(this.product.ownerId);

      setState(() {
        isLoading = false;
      });
    }
    catch(err){
      print('Error: $err');
      setState(() {
        isLoading = false;
      });
    }
  }


  // final myFormKey = GlobalKey<FormState>();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DETAILS'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image(
                  image: NetworkImage(this.product.imgUrl) ,
                  fit: BoxFit.cover,
                  width: 350,
                  height: 250,
                )),
            SizedBox(
              height: 20,
            ),
            Text(
              'Product Name: '+this.product.name,
              style: TextStyle(fontSize: 23),
              textAlign: TextAlign.left,
            ),
            Text(
              'Added by: ' + this.productOwner.name,
              style: TextStyle(
                fontSize: 18,
                height: 2.2,
              ),
              textAlign: TextAlign.left,
            ),
            Text(
              'Contact: ' + this.productOwner.phoneNo,
              style: TextStyle(
                fontSize: 18,
                height: 2.2,
              ),
              textAlign: TextAlign.left,
            ),
            // SizedBox(
            //   height: 20,
            // ),
            Text(
              'Time Used: ' + '${this.product.years} Years ${this.product.months} Months',
              style: TextStyle(
                fontSize: 18,
                height: 2.2,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              this.product.description,
              style: TextStyle(fontSize: 14, height: 1.3),
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              color: Theme.of(context).accentColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(23.0),
                side: BorderSide(
                    color: Theme.of(context).accentColor, width: 1.5),
              ),
              child: Text(
                'Message',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              elevation: 4,
              onPressed: () {
                // Navigator.push(
                //     context, MaterialPageRoute(builder: (context) => Detail()));
              },
              height: 45,
            ),
          ],
        ),
      ),
    );
  }
}