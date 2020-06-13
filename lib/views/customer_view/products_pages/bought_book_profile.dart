import 'dart:typed_data';

import 'package:Selfsahaf/controller/cart_service.dart';
import 'package:Selfsahaf/controller/user_controller.dart';
import 'package:Selfsahaf/models/order.dart';
import 'package:Selfsahaf/models/user.dart';
import 'package:Selfsahaf/views/customer_view/products_pages/refund_page.dart';
import 'package:Selfsahaf/views/customer_view/profile_pages/seller_profile.dart';
import 'package:Selfsahaf/views/errors/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:Selfsahaf/models/book.dart';
import 'package:Selfsahaf/views/customer_view/main_view/page_classes/main_page/home_page_carousel.dart';
import 'package:Selfsahaf/views/customer_view/products_pages/book_settings.dart';
import 'package:Selfsahaf/controller/product_services.dart';
import 'package:get_it/get_it.dart';
import 'package:Selfsahaf/views/customer_view/shopping_cart/shopping_cart.dart';
import 'package:Selfsahaf/views/errors/error_dialog.dart';

class BoughtBookProfile extends StatefulWidget {
  final Order selectedBook;
  int amount;
  BoughtBookProfile({@required this.selectedBook, this.amount});
  @override
  _BoughtBookProfileState createState() => _BoughtBookProfileState();
}

class _BoughtBookProfileState extends State<BoughtBookProfile> {
  Order ourOrder;
  ProductService get _productService => GetIt.I<ProductService>();
  CartService get _cartService => GetIt.I<CartService>();
  AuthService get _userService => GetIt.I<AuthService>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  User _user;
  int _itemCount = 1;
  List<Image> images;
  bool _loading = true;
  @override
  void initState() {
    this.ourOrder = widget.selectedBook;
    _user = _userService.getUser();
    if (widget.amount != null) {
      this._itemCount = widget.amount;
    }
    _fetchData();
  }

  _fetchData() async {
    _productService.getAllImages(widget.selectedBook.product.productID).then((value) {
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
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 12,
        title: Container(
            height: 50, child: Image.asset("images/logo_white/logo_white.png")),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.assignment,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RefundPage(ourOrder: widget.selectedBook,)),
              );
            },
          ),
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
                      padding: const EdgeInsets.fromLTRB(6, 6, 6, 0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: double.maxFinite,
                            height: 40,
                            child: Center(
                                child: Text(
                              widget.selectedBook.product.name,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            )),
                          ),
                          Container(
                            width: double.maxFinite,
                            height: 40,
                            child: Center(
                                child: Text(
                              "Price: " +
                                  (widget.selectedBook.price *
                                          widget.amount.toInt())
                                      .toString() +
                                  " TL",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            )),
                          ),
                        ],
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
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SellerProfilePage(
                                              seller: widget.selectedBook.product,
                                            )),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: const Radius.circular(20),
                                        topRight: const Radius.circular(20),
                                        bottomLeft: const Radius.circular(20),
                                        bottomRight: const Radius.circular(20),
                                      )),
                                  width: double.maxFinite,
                                  height: 45,
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "Seller: ",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                        Text(
                                            "${widget.selectedBook.product.userName}" +
                                                " ${widget.selectedBook.product.userSurname}",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 2,
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
                                      Text(widget.selectedBook.product.authorName,
                                          style: TextStyle(color: Colors.white))
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 2,
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
                                      Text(widget.selectedBook.product.language,
                                          style: TextStyle(color: Colors.white))
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 2,
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
                                      Text(widget.selectedBook.product.categoryName,
                                          style: TextStyle(color: Colors.white))
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 2,
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
                                      Text(widget.selectedBook.product.isbn,
                                          style: TextStyle(color: Colors.white))
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Container(
                                width: double.maxFinite,
                                height: 45,
                                child: Center(
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "Copies You Bought: ",
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
                                height: 2,
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
                                      widget.selectedBook.product.publisher,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                )),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Container(
                                width: double.maxFinite,
                                height: 45,
                                child: Center(
                                    child: Row(
                                  children: <Widget>[
                                    Text(
                                      "Shipping Company: ",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      widget.selectedBook.shippingInfo.shippingcompany.companyName,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                )),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Container(
                                width: double.maxFinite,
                                height: 45,
                                child: Center(
                                    child: Row(
                                  children: <Widget>[
                                    Text(
                                      "Shipping Tracking Number: ",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      widget.selectedBook.shippingInfo.trackingNumber,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                )),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Container(
                                width: double.maxFinite,
                                height: 45,
                                child: Center(
                                    child: Row(
                                  children: <Widget>[
                                    Text(
                                      "Seller Name: ",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      widget.selectedBook.seller.name,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                )),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Container(
                                width: double.maxFinite,
                                height: 45,
                                child: Center(
                                    child: Row(
                                  children: <Widget>[
                                    Text(
                                      "Seller Phone Number: ",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      widget.selectedBook.seller.phoneNumber,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                )),
                              ),
                              SizedBox(
                                height: 2,
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
                                                widget.selectedBook.product.description,
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
