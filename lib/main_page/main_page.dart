import 'package:flutter/material.dart';
import 'package:selfsahaf/main.dart';
import 'package:selfsahaf/page_classes/sahaf_drawer.dart';
import './drawer.dart';

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
        appBar: AppBar(
      title:  
      Text("SelfSahaf.com",
      textAlign: TextAlign.center,
      ),
      ),
      drawer: Drawer(
        elevation: 5.0,

        child: MainPageDrawer()
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