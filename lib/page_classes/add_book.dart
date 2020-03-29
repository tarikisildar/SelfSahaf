import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class AddBook extends StatefulWidget{
  @override
  _AddBookState createState() => new _AddBookState();
}

class _AddBookState extends State<AddBook>{
  var bookNameController = new TextEditingController();
  final dio = new Dio();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Container(height: 20,child: Image.asset("images/logo_white/logo_white.png"),),
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
                padding: const EdgeInsets.only(top:15.0),
                child: TextFormField(
                  controller: bookNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Kitabin Adi"
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:15.0),
                child: RaisedButton(
                  onPressed: () => {
                    _addBook()
                  },
                  child: Container(
                    child: Text("sa"),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _addBook() async {
    final response = await dio.post('http://142.93.106.79/product/addBook');
    print(response);
  }
}