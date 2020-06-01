import 'package:flutter/material.dart';
import 'package:selfsahaf/models/book.dart';


class BookCard extends StatelessWidget {
  final String bookName;
  final String picture;
  final String writer;
  final int price;
  final String seller;
  BookCard({this.bookName, this.picture, this.price, this.seller, this.writer});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Container(
      child: Padding(
        child: InkWell(
          onTap: () {
            
          },
          child: GridTile(
            footer: Container(
                width: 40,
                color: Colors.transparent,
                child: Column(
                  children: <Widget>[
                    Text(bookName,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(
                      "$price",
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.w800),
                    ),
                  ],
                )),
            child: Container(
              child: Image.asset(picture, fit: BoxFit.cover),
            ),
          ),
        ),
        padding: EdgeInsets.all(4.0),
      ),
    ));
  }
}
