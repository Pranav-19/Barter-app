import 'package:exchange_app/ItemCard.dart';
import 'package:exchange_app/addItem.dart';
import 'package:exchange_app/models/product.dart';
import 'package:exchange_app/products_list.dart';
import 'package:exchange_app/services/database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import './models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();

}

class _ProfileState extends State<Profile> {

AppUser currUser;
List<Product> products = List<Product>();
bool isLoading = false;
DatabaseService _database = DatabaseService(uid: FirebaseAuth.instance.currentUser.uid);

  @override
  void initState(){
    super.initState();
    this.fetchDetails();
  }

  void fetchDetails() async{
    try{
      setState(() {
        isLoading = true;
      });

       await this.fetchUserDetails();
       await this.fetchProductDetails();
       print('${currUser.name}  ${currUser.phoneNo}');
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

  Future fetchUserDetails() async{
   currUser = await _database.getProductOwner(_database.uid);
  }

  Future fetchProductDetails() async{
    products = await _database.myProducts;
  }



  @override
  Widget build(BuildContext context) {
    return isLoading?
        LoadingScreen()
        :
    Scaffold(
        body:Container(
        padding: EdgeInsets.symmetric(vertical: 10.0),
      color: Colors.white,
      child: SingleChildScrollView(
      child:Column(
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
//                    SizedBox(height:10,),
                    IconButton(
                      icon:FaIcon(FontAwesomeIcons.solidUserCircle),
                      iconSize: 120.0,
                      color: Colors.red,
                    ),
                    SizedBox(width: 20,height: 12),
                    Column(
                      children: <Widget>[
                        Text(currUser.name,
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 25),),
                        SizedBox(height:5,),
                        Text(currUser.phoneNo,
                            style: TextStyle(color: Colors.black87, fontSize: 17))
                      ],
                    ),
                    SizedBox(height:15,),

                    Text('Items listed',
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 23, decoration: TextDecoration.underline)),
                    SizedBox(height: 15, width: 18)

                  ],
                ),
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 10.0),
//            child:Expanded(
            child:ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index) {
                final product = products[index];
                return ItemCard(product: product);
              },
            )
//            )
          )
        ],
      )
      )
    ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddItem()));
        },
      ),
    );
  }
}

