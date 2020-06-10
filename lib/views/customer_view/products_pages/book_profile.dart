import 'dart:typed_data';

import 'package:Selfsahaf/views/customer_view/profile_pages/seller_profile.dart';
import 'package:flutter/material.dart';
import 'package:Selfsahaf/models/book.dart';
import 'package:Selfsahaf/views/customer_view/main_view/page_classes/main_page/home_page_carousel.dart';
import 'package:Selfsahaf/views/customer_view/products_pages/book_settings.dart';
import 'package:Selfsahaf/controller/product_services.dart';
import 'package:get_it/get_it.dart';

class BookProfile extends StatefulWidget {
  Book selectedBook;
  bool isproduct = false;
  BookProfile({@required this.selectedBook, @required this.isproduct});
  @override
  _BookProfileState createState() => _BookProfileState();
}

class _BookProfileState extends State<BookProfile> {
  ProductService get _productService => GetIt.I<ProductService>();
  List<Image> images;
  bool _loading = true;
  @override
  void initState() {
    _fetchData();
  }

  _fetchData() async {
    _productService.getAllImages(widget.selectedBook.productID).then((value) {
      setState(() {
        if (value.error) {
          print("error");
        } else {
          images = value.data;
          _loading = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 12,
        title: Container(
            height: 50, child: Image.asset("images/logo_white/logo_white.png")),
        actions: <Widget>[
          (widget.isproduct)
              ? IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookSettingsPage(
                            selectedBook: widget.selectedBook,
                          ),
                        )).then((e) {
                      if (e != null) {
                        Navigator.of(context).pop(e);
                      }
                    });
                  })
              : IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () => print("asas"))
        ],
      ),
      body: (_loading)
          ? Container(
              color: Colors.transparent,
              child: Center(
                  child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              )))
          : Center(
              child: Container(
                color: Color(0xffe65100),
                child: Column(
                  children: <Widget>[
                    HomePageCarousel(
                      bookImages: images,
                    ),
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
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
                                )),
                              ),
                            ),
                            Expanded(flex: 2, child: SizedBox()),
                            Expanded(
                                flex: 6,
                                child: InkWell(
                                  child: Container(
                                    width: double.maxFinite,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25))),
                                    child: Center(
                                        child: Text(
                                      "${widget.selectedBook.price} TL",
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 18),
                                    )),
                                  ),
                                  onTap: () => print("sa"),
                                ))
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 2.2,
                      color: Colors.white,
                    ),
                    Container(
                      height: 70,
                      width: MediaQuery.of(context).size.width - 40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 10,
                              child: Text(
                                widget.selectedBook.sellerID.toString(),
                                style: TextStyle(color: Colors.deepPurple),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: InkWell(
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.deepPurple,
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SellerProfilePage()),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
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
                                      Text("widget.selectedBook.sellerName",
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
                                        "Quantity: ",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Text(
                                          widget.selectedBook.quantity
                                              .toString(),
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
