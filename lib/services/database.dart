import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exchange_app/models/user.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';
import 'package:path/path.dart';
import '../models/product.dart';
import '../models/user.dart';


class DatabaseService{

  String uid = '';

  DatabaseService({this.uid});

  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
  final CollectionReference productCollection = FirebaseFirestore.instance.collection('products');
  final firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;


  Future<void> setUserData(String name,String phoneNo) async {
//    print('Setting..');
     await userCollection.doc(uid).set({
      'name':name,
      'phoneNo':phoneNo
    }).then((value) => print('User data set'))
    .catchError((error) => print('Failed to set user: $error'));
  }

  Future<void> updateUserData(String name,String phoneNo) async {
    await userCollection.doc(uid).update({
      'name':name,
      'phoneNo':phoneNo
    }).then((value) => print('User data updated'))
        .catchError((error) => print('Failed to update user: $error'));
  }

  Future<void> addProduct(String name, String description,int yearsOld,int monthsOld,String imageUrl) async{

   await productCollection.doc(uid).set({});

  productCollection.doc(uid).collection('myProducts').add({
    'name':name,
    'description':description,
    'yearsOld':yearsOld,
    'monthsOld':monthsOld,
    'imageUrl':imageUrl,
    'ownerId':this.uid
  }).then((value) => print('New product added'))
      .catchError((err) => print('Product could not be added: $err'));
  }

  Future<String> addProductImage(File f)  async{
    String  fileName = basename(f.path);
    firebase_storage.UploadTask uploadTask =  storage.ref('productImages').child(fileName).putFile(f);
    firebase_storage.TaskSnapshot taskSnapshot =  await uploadTask.whenComplete(() => print('Picture uploaded'));
    return taskSnapshot.ref.getDownloadURL();
  }

  Future get myProducts async {
      List<Product> products = List<Product>();
      // Product prod;

     await productCollection.doc(uid).collection('myProducts').get().then((value) =>
     {
       for(final doc in value.docs){
        //  print(doc.get('imageUrl'))
         if(doc.exists)
           products.add(Product(
          name: doc.get('name'),
          description: doc.get('description'),
          imgUrl: doc.get('imageUrl'),
          months: doc.get('monthsOld'),
          years: doc.get('yearsOld')
        ))
     }
     });
    print('Products');
    for(final p in products){
      print('${p.name} ${p.description} ${p.years} ${p.months} ${p.imgUrl}');
    }


     return products;
  }


  Future get allProducts async{
    List<Product> products= List<Product>();

    await productCollection.get().then((querySnapshot) async => {
      for(final doc in querySnapshot.docs){
        if(doc.exists && doc.id!=this.uid){

            await doc.reference.collection('myProducts').get().then((value) => {
            for(final document in value.docs){

              if(document.exists){
                products.add(Product(
                    name: document.get('name'),
                    description: document.get('description'),
                    imgUrl: document.get('imageUrl'),
                    months: document.get('monthsOld'),
                    years: document.get('yearsOld')
                ))
              }
            }
          })
        }
      }
    });
    return products;
  }


  Future getProductOwner(String uid) async{
    final u = await userCollection.doc(uid).get();
    AppUser user = new AppUser(name: u.get('name'),phoneNo: u.get('phoneNo'));
    return user;
  }

}