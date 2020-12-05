import 'package:exchange_app/loading.dart';
import 'package:exchange_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}


class _AddItemState extends State<AddItem> {
  final myFormKey = GlobalKey<FormState>();
  final picker = ImagePicker();
  File _image;
  int _currentIndex = 0;
  int _years=0,_months=0;
  String name='',description = '',imageUrl = '';
  SnackBar snackBar;
  bool loading =false;
  final DatabaseService _database = new DatabaseService(uid: FirebaseAuth.instance.currentUser.uid);


  Future getImage() async{
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if(pickedFile!=null){
        _image = File(pickedFile.path);
        print(pickedFile.path);
      }
      else
        print('No image selected');
    });

  }

  Future onSubmit() async{
    if(_image!=null){
     imageUrl = await _database.addProductImage(_image);
    }
    return _database.addProduct(name, description, _years, _months, imageUrl).then((value) => {
      // print('Product added to firstore');
      snackBar = SnackBar(content: Text('Product has been added'))})
      .catchError((err) => print('Error adding product to firestore: $err'));

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:SafeArea(

        child:Container(
        decoration: BoxDecoration(),
        //padding: EdgeInsets.only(top: 5),
        child: Form(
          key: myFormKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                GestureDetector(
                  onTap: (){
                    getImage();
                  },
                child:Container(
                  width: 250,
                  height: 250,
                  child:_image == null?
                  Center(
                    child: Text(
                      'CLICK HERE TO CAPTURE IMAGE',
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ))
                      :Image.file(_image,fit: BoxFit.cover,),
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    border: Border.all(
                      // color: Colors.black,
                      width: 3.0,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                )
                ),
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
                      labelText: 'Name of the Product',
                      labelStyle:
                      TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(
                          color: Colors.deepPurple,
                          width: 2,
                        ),
                      ),
                    ),
                    textCapitalization: TextCapitalization.words,
                    onChanged: (val){
                      name = val;
                    },
                  ),
                ),
              SizedBox(
                height: 15,
              ),
              Text('How old is the product?',
                  style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,fontSize: 19)),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text('YEARS',style: TextStyle(fontSize: 17,color: Colors.blueAccent)),
                        new NumberPicker.integer(
                          selectedTextStyle: TextStyle(color: Colors.blueAccent,fontSize: 23.0),
                          initialValue: _years,
                          minValue: 0,
                          maxValue: 50,
                          onChanged: (newValue) =>
                              setState(() => _years = newValue),

                        ),
                      ],
                    ),
                  Column(
                    children: [
                      Text('MONTHS',style: TextStyle(fontSize: 17,color: Colors.blueAccent)),
                      new NumberPicker.integer(
                        selectedTextStyle: TextStyle(color: Colors.blueAccent,fontSize: 23.0),
                        initialValue: _months,
                        minValue: 0,
                        maxValue: 11,
                        onChanged: (newValue) =>
                            setState(() => _months = newValue),
                      ),
                    ],
                  )

                  ],
                ),
                Container(
                  margin: EdgeInsets.all(12),
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      labelText: 'Description',
                      labelStyle:
                      TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(
                          color: Colors.deepPurple,
                          width: 2,
                        ),
                      ),
                    ),
                    textCapitalization: TextCapitalization.words,
                    onChanged: (val){
                      description = val;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(15),
                  width: 180,
                  child: MaterialButton(
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(23.0),
                    ),
                    child: Text(
                      'SUBMIT',
                      style: TextStyle(
                          fontSize: 21,
                          color: Colors.white),
                    ),
                    elevation: 4,
                    onPressed: () async{
//                      Navigator.push(context,
//                          MaterialPageRoute(builder: (context) => Detail()));
                    setState(() {
                      loading = true;
                    });
                    await onSubmit();
                    Navigator.pop(context);
                    setState(() {
                      loading = false;
                    });
                    Scaffold.of(context).showSnackBar(snackBar);
                    },
                    height: 45,
                  ),
                ),
//                RaisedButton(
//                  child: Text('Reset'),
//                  onPressed: () {},
//                  shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.circular(30),
//                  ),
//                  color: Theme.of(context).accentColor,
//                  textColor: Theme.of(context).primaryTextTheme.button.color,
//                ),
                SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
        ),
      ))
    );
  }
}
