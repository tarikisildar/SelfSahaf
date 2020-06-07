import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:selfsahaf/controller/book_controller.dart';

class SearchPage extends StatefulWidget {
  // ExamplePage({ Key key }) : super(key: key);
  @override
  _SearchPageState createState() => new _SearchPageState();
}

class _SearchPageState extends State<SearchPage>{
    BookService get _bookService => GetIt.I<BookService>();
    Uint8List sa;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bookService.getImage(2, 5, 1).then((value) {
      setState(() {
        this.sa=value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: (sa==null)?Text("Badi"):Image.memory(sa, fit: BoxFit.cover,scale: 0.1, ),
      ),
    );
  }
  
}