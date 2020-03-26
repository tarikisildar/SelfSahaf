import 'package:flutter/material.dart';
import 'package:selfsahaf/page_classes/BookCard.dart';
import 'package:selfsahaf/page_classes/HomePageCarousel.dart';
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
        title: Text("SelfSahaf.com"),
        actions: <Widget>[
          new IconButton(icon: Icon(Icons.search) , onPressed: (){
            print("search");
          }),
          new IconButton(icon: Icon(Icons.shopping_cart) , onPressed: (){
            print("shoping");
          }),
        ],
      ),
      drawer: SahafDrawer(
      ),
      body: new ListView(
        children: <Widget>[
          HomePageCarousel(),
          Padding(padding: EdgeInsets.all(0.1)),
          Container(height:400,child: BookCard(),)
        ],
      )
    );
  }

}
 