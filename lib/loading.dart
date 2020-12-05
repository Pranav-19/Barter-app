import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(

      constraints: BoxConstraints.expand(),
    decoration: BoxDecoration(
      image:  DecorationImage(
          image: AssetImage("images/bg_img.jpg"),
          fit: BoxFit.cover,
    ),
    ),
    padding: EdgeInsets.only(top: 25),
      child: Center(
        child: SpinKitSpinningCircle(
          color:Color.fromRGBO(90, 56, 167,1.0),
          size: 50.0,
        ),
      ),
    );
  }
}
