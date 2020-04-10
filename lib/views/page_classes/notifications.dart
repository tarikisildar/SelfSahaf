import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  // ExamplePage({ Key key }) : super(key: key);
  @override
  _NotificationsPageState createState() => new _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage>{
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