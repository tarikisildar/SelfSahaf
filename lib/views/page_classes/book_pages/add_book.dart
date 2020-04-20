import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:selfsahaf/views/registration/input_field.dart';

class AddBook extends StatefulWidget {
  @override
  _AddBookState createState() => new _AddBookState();
}

class _AddBookState extends State<AddBook> {
  TextEditingController _booknameController = new TextEditingController();
  TextEditingController _authorController = new TextEditingController();
  TextEditingController _categoryController = new TextEditingController();
  TextEditingController _descriptionController = new TextEditingController();
  TextEditingController _priceController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe65100),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(Icons.picture_in_picture_alt,color: Color(0xffe65100),),
        onPressed: () {
          print("onayladim devam et");
        },
      ),
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        title: Container(
          height: 50,
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
      body: Container(
        
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0, top: 12.0),
                  child: Text("Add New Book",style: TextStyle(color:Colors.white,fontSize: 25),),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0, top: 12.0),
                  child: InputField(
                    controller: _booknameController,
                    labelText: "Book's Name", validation: null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: InputField(
                    controller: _authorController,
                    labelText: "Author's Name", validation: null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: InputField(
                    controller: _categoryController,
                    labelText: "Category", validation: null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: InputField(
                    controller: _descriptionController,
                    labelText: "Description", validation: null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 3.0, bottom: 3.0),
                  child: InputField(
                    controller: _priceController,
                    labelText: "Price", validation: null,
                  ),
                ),
                Container(
                  height: 55,
                  width: 220,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 7.0, bottom: 3.0),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          side:
                              BorderSide(color: Color.fromRGBO(230, 81, 0, 1))),
                      child: Text(
                        "Add Photo",
                        style: TextStyle(color: Color(0xffe65100)),
                      ),
                      color: Colors.white,
                      onPressed: () {
                        print("resim cekme islemi");
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
