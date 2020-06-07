import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:selfsahaf/controller/book_controller.dart';
import 'package:selfsahaf/models/book.dart';

class BookCard extends StatefulWidget {
  final String bookName;
  final String picture;
  final String writer;
  final double price;
  final String seller;
  final int productID, sellerID;
  BookCard(
      {this.bookName,
      this.picture,
      this.price,
      this.seller,
      this.writer,
      this.productID,
      this.sellerID});

  @override
  _BookCardState createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  BookService get _bookService => GetIt.I<BookService>();
  Uint8List photo;
  @override
  void initState() {
    super.initState();
    _bookService.getImage(widget.sellerID, widget.productID, 1).then((value) {
      setState(() {
        this.photo = value;
      });
    });
  }

  bool clicked = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Container(
      child: Padding(
        child: InkWell(
          onTap: () {
            setState(() {
              clicked = !clicked;
            });
          },
          child: (clicked)
              ? Container(
                  width: 40,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(widget.bookName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Theme.of(context).primaryColor)),
                      Text(
                        "Author: " + widget.writer,
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        "${widget.price}",
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.w800),
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        child: InkWell(
                          onTap: (){
                            print("sa");
                          },
                          child:Icon(Icons.send,
                            color: Theme.of(context).primaryColor, size: 50),)
                      )
                    ],
                  ))
              : GridTile(
                  child: Container(
                    child: (photo == null)
                        ? Icon(
                            Icons.book,
                            color: Colors.white,
                            size: 80,
                          )
                        : Image.memory(photo, fit: BoxFit.cover),
                  ),
                ),
        ),
        padding: EdgeInsets.all(4.0),
      ),
    ));
  }
}
