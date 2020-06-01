import 'package:flutter/material.dart';

class AccountProfilePage extends StatefulWidget {
  // ExamplePage({ Key key }) : super(key: key);
  @override
  _AccountProfilePageState createState() => new _AccountProfilePageState();
}

class _AccountProfilePageState extends State<AccountProfilePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text("Badi"),
      ),
    );
  }
  
}