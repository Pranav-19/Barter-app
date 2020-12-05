import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  @override
  _Detail createState() => _Detail();
}

class _Detail extends State<Detail> {

  final myFormKey = GlobalKey<FormState>();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DETAILS '),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image(
                  image: AssetImage('images/1.jpg'),
                  fit: BoxFit.cover,
                  width: 350,
                  height: 250,
                )),
            SizedBox(
              height: 20,
            ),
            Text(
              'Product Name',
              style: TextStyle(fontSize: 23),
              textAlign: TextAlign.left,
            ),
            Text(
              'Price: ' + '101111110000' + ' Rs',
              style: TextStyle(
                fontSize: 18,
                height: 2.2,
              ),
              textAlign: TextAlign.left,
            ),
            Text(
              ' Each entry in the asset section of the pubspec.yaml should correspond to a real file, with the exception of the main asset entry. If the main asset entry doesn’t correspond to a real file, then the asset with the lowest resolution is used as the fallback for devices with device pixel ratios below that resolution ',
              style: TextStyle(fontSize: 14, height: 1.3),
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              color: Color.fromRGBO(90, 56, 167, 1.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(23.0),
                side: BorderSide(
                    color: Color.fromRGBO(213, 196, 105, 1.0), width: 1.5),
              ),
              child: Text(
                'BUY',
                style: TextStyle(
                    fontSize: 21, color: Color.fromRGBO(213, 196, 105, 1.0)),
              ),
              elevation: 4,
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Detail()));
              },
              height: 45,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        backgroundColor: Color.fromRGBO(90, 56, 167, 1.0),
        selectedItemColor: Colors.white,
        unselectedItemColor: Color.fromRGBO(213, 196, 105, 1.0),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        onTap: (value) {
          // Respond to item press.
          setState(() => _currentIndex = value);
        },
        items: [
          BottomNavigationBarItem(
            title: Text('Home'),
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            title: Text('Add Item'),
            icon: Icon(Icons.add_circle_outline),
          ),
          BottomNavigationBarItem(
            title: Text('My Profile'),
            icon: Icon(Icons.account_circle),
          ),
          BottomNavigationBarItem(
            title: Text('Notifications'),
            icon: Icon(Icons.notifications_none),
          ),
        ],
      ),
    );
  }
}