import 'package:Selfsahaf/models/book.dart';
import 'package:flutter/material.dart';

class SellerBooksPage extends StatefulWidget {
  Book bookfrom;
  SellerBooksPage({this.bookfrom});
  @override
  _SellerBooksPage createState() => new _SellerBooksPage();
}

class _SellerBooksPage extends State<SellerBooksPage> {
  
  Book bookfrom;
  @override
  void initState() { 
    this.bookfrom = widget.bookfrom;
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        Container(
          child: Text("${bookfrom.categoryName}"),
        )
      ],
    ));
  }
}
