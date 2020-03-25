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
      appBar: AppBar(
        title: Text("sasasasa"),
      ),
      drawer: SahafDrawer(),
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