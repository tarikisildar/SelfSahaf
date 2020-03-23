import 'package:flutter/material.dart';
import 'package:selfsahaf/page_classes/sahaf_drawer.dart';

class MainPage extends StatefulWidget{
  
  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      drawer: Drawer(
        elevation: 5.0,

        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Column(
              children: <Widget>[
                Text("sa"),
                Text("as")
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child:Column(
          children: <Widget>[
            Text(
              "sa"
            ),
          ],
        )
      ),
    );
  }

}