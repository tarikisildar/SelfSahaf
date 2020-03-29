import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class AddBook extends StatefulWidget {
  @override
  _AddBookState createState() => new _AddBookState();
}

class _AddBookState extends State<AddBook> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 20,
          child: Image.asset("images/logo_white/logo_white.png"),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                print("shopping");
              }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: TextFormField(
                    
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: "Author"),
                  )
                  ),
              Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: "Book Name"),
                  )),
              Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: "Categori"),
                  )),
              Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: "Description"),
                  )),
              Padding(
                  padding: const EdgeInsets.only(top: 3.0, bottom: 3.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: "Language"),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
