import 'package:flutter/material.dart';
import 'package:selfsahaf/views/page_classes/main_page/home_page_carousel.dart';
import 'package:selfsahaf/models/book.dart';
import 'package:selfsahaf/views/products_pages/book_settings.dart';

class BookProfile extends StatefulWidget {
  Book selectedBook;
  BookProfile({@required this.selectedBook});
  @override
  _BookProfileState createState() => _BookProfileState();
}

class _BookProfileState extends State<BookProfile> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 12,
        title: Container(
            height: 50, child: Image.asset("images/logo_white/logo_white.png")),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.settings), onPressed: () {
            print("object");
             Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BookSettingsPage(selectedBook: widget.selectedBook,),));
            
          })
        ],
      ),
      body: Center(
        child: Container(
          color: Color(0xffe65100),
          child: Column(
            children: <Widget>[
              HomePageCarousel(),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: SafeArea(
                  
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 20,
                        child: Container(
                          width: double.maxFinite,
                          height: 70,
                          child: Center(
                              child: Text(
                            widget.selectedBook.name,
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          )),
                        ),
                      ),
                      Expanded(flex: 2, child: SizedBox()),
                      Expanded(
                        flex: 6,
                        child: Container(
                          width: double.maxFinite,
                          height: 70,
                          child: Center(
                              child: Text(
                            "${widget.selectedBook.price} TL",
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                thickness: 2.2,
                color: Colors.white,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: double.maxFinite,
                          height: 45,
                          child: Center(
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "Author: ",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(widget.selectedBook.authorName,
                                    style: TextStyle(color: Colors.white))
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: double.maxFinite,
                          height: 45,
                          child: Center(
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "Language: ",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(widget.selectedBook.language,
                                    style: TextStyle(color: Colors.white))
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: double.maxFinite,
                          height: 45,
                          child: Center(
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "Category: ",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(widget.selectedBook.categoryName,
                                    style: TextStyle(color: Colors.white))
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: double.maxFinite,
                          height: 45,
                          child: Center(
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "ISBN: ",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(widget.selectedBook.isbn,
                                    style: TextStyle(color: Colors.white))
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: double.maxFinite,
                          height: 45,
                          child: Center(
                              child: Row(
                            children: <Widget>[
                              Text(
                                "Publisher: ",
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                widget.selectedBook.publisher,
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          )),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Divider(
                          thickness: 1.2,
                          color: Colors.white,
                        ),
                        Container(
                          width: double.maxFinite,
                          height: 120,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Center(
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    child: SingleChildScrollView(
                                        child: Text(
                                          "More About Book:\n " +
                                      widget.selectedBook.description,
                                      style:
                                          TextStyle(color: Colors.white),
                                    )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
