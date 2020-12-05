import 'package:exchange_app/ItemCard.dart';
import 'package:exchange_app/models/product.dart';
import 'package:exchange_app/services/auth.dart';
import 'package:exchange_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class ProductsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>_ProductListState();
}

class _ProductListState extends State<ProductsList> {

//  final AuthService _auth = AuthService();
  final DatabaseService _database = DatabaseService(uid: FirebaseAuth.instance.currentUser.uid);
  List<Product> products = new List<Product>();
  bool isLoading = false;

  @override
  void initState(){
    super.initState();
    this.getProducts();
  }

  void getProducts() async{

    try {
      setState(() {
        isLoading = true;
      });
      products = await _database.allProducts;

      setState(() {
        isLoading = false;
      });
    }
    catch(err){
      print("Error$err");
      setState(() {
        isLoading = false;
      });
    }
//     _database.getProductOwner(FirebaseAuth.instance.currentUser.uid);
  }


  @override
  Widget build(BuildContext context) {
    return
    isLoading?LoadingScreen()
      :Container(
        padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: ListView.builder(
            itemCount: products.length,
            itemBuilder: (BuildContext context, int index) {
              final product = products[index];
              return ItemCard(product: product);
            },
          ),
        ),
      );

  }

}


class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child:Center(
      child: SpinKitChasingDots(
        color: Theme.of(context).primaryColor,
        size: 45,
      ),
    )
    );
  }
}











