import 'dart:typed_data';

import 'package:Selfsahaf/views/customer_view/products_pages/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:Selfsahaf/controller/book_controller.dart';
import 'package:Selfsahaf/views/registration/input_field.dart';

class SearchPage extends StatefulWidget {
  // ExamplePage({ Key key }) : super(key: key);
  @override
  _SearchPageState createState() => new _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController queryController;

  // _SearchPageState(){
  //   queryController.addListener(() {
  //     if(queryController.text.length>=3){
  //       print("ARKAYA SEARCH ISTEGI");
  //     }
  //     else {
  //       print(3-queryController.text.length);
  //     }

  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepOrange,
            bottom: TabBar(
              tabs: [
                Tab(child: Text("Books",style: TextStyle(color: Colors.white),),),
                Tab(child: Text("Categories",style: TextStyle(color: Colors.white),),),
                Tab(child: Text("ISBN",style: TextStyle(color: Colors.white),),),
              ],
            ),
            title: Container(
          child: TextFormField(
            style: TextStyle(color: Colors.white),
            controller: queryController,
            decoration: InputDecoration(
                hintText: "Type to Search",
                hintStyle: TextStyle(color: Colors.white),
                border: InputBorder.none),
          ),
        ),
          ),
          body: TabBarView(
            children: [
              Container(
                color: Colors.deepOrange,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    children: <Widget>[
                      Text("BOOK CEK"),
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.deepOrange,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    children: <Widget>[
                      Text("KATEGORI CEK"),
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.deepOrange,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    children: <Widget>[
                      Text("ISBN CEK"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
