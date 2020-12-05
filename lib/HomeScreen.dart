import 'package:exchange_app/products_list.dart';
import 'package:exchange_app/profile.dart';
import 'package:exchange_app/services/auth.dart';
import 'package:flutter/material.dart';


class Choice {
  final String title;
  const Choice({this.title});
}


class ChoicePage extends StatelessWidget {
  const ChoicePage({Key key, this.choice}) : super(key: key);
  final Choice choice;

  @override
  Widget build(BuildContext context) {
    // final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return Card(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              choice.title,
            ),
          ],
        ),
      ),
    );
  }
}


class Chats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return   Container(
      margin: EdgeInsets.only(top:10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      child: ProductsList(),
    );
  }
}

const List<Choice> choices = <Choice>[
  Choice(title:'Feed'),
  Choice(title: 'Chats'),
  Choice(title: 'Profile')
];

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.menu),
              iconSize: 30.0,
              color: Colors.white,
              onPressed: () { },
            ),
            title: Text(
              'Goods Exchange',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            elevation: 0.0,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.logout),
                iconSize: 30.0,
                color: Colors.white,
                onPressed: () async{
                  await _auth.signout();
                },
              ),
            ],
            bottom: TabBar(
                tabs: choices.map((choice) => Tab(
                  child: Text(choice.title, style: TextStyle(fontSize: 23, letterSpacing: 1.2)),
                ) ).toList()
            ),
          ),
          body: TabBarView(
              children:
              // choices.map <Widget>((choice) =>
              //    Padding(
              //     padding: const EdgeInsets.all(20.0),
              //     child: ChoicePage(choice: choice,),
              //   )
              // ).toList()
              [Chats(),
                Chats(),
                Profile()]
          )
      ),
    );
  }
}
