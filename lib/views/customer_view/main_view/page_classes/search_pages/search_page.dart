import 'dart:typed_data';

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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
        leading: IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {}),
      ),
      body: Center(child: Text("Badi")),
    );
  }
}
