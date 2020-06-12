import 'dart:ffi';

import 'package:Selfsahaf/controller/rating_controller.dart';
import 'package:Selfsahaf/models/book.dart';
import 'package:Selfsahaf/models/rating.dart';
import 'package:Selfsahaf/views/customer_view/profile_pages/seller_books_page.dart';
import 'package:Selfsahaf/views/customer_view/profile_pages/seller_comments_page.dart';
import 'package:Selfsahaf/views/errors/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:Selfsahaf/views/customer_view/profile_pages/adress_page.dart';
import 'package:Selfsahaf/views/customer_view/profile_pages/history_page.dart';
import 'package:Selfsahaf/controller/user_controller.dart';
import 'package:Selfsahaf/views/customer_view/profile_pages/settings_page.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class SellerProfilePage extends StatefulWidget {
  Book seller;
  SellerProfilePage({this.seller});
  @override
  _SellerProfilePage createState() => new _SellerProfilePage();
}

class _SellerProfilePage extends State<SellerProfilePage> {
  Book seller;
  AuthService userService = GetIt.I<AuthService>();
  RatingService _ratingService = GetIt.I<RatingService>();
  List<Rating> allRatings;
  bool rated= false;
  int avgrating;
  String msg;
  _getRatings(BuildContext context) async {
    _ratingService.getRatings(seller.sellerID).then((value) {
      print(value.data);
      if (!value.error) {
        setState(() {
          this.allRatings = value.data;
        });
      } else {
        ErrorDialog().showErrorDialog(context, "Error", value.errorMessage);
        setState(() {
          this.allRatings = value.data;
        });
      }
    });
  }

  @override
  void initState() {
    this.seller = widget.seller;
    _getRatings(context);
    _avgRating(context);
  }

  _avgRating(BuildContext context)async{
    _ratingService.getAvgRating(seller.sellerID).then((value) {
      print(value.data);
      if (!value.error) {
        setState(() {
          this.avgrating = value.data;
        });
      } else {
        ErrorDialog().showErrorDialog(context, "Error", value.errorMessage);
        setState(() {
          this.avgrating = value.data;
        });
      }
    });
  }

  List<Widget> _pages = [AdressesPage(), HistoryPage()];
  var controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Container(
            height: 50, child: Image.asset("images/logo_white/logo_white.png")),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingsPage()));
              }),
        ],
      ),
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          children: <Widget>[
            Container(
                child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.perm_identity,
                      color: Color(0xffe65100),
                      size: 128,
                    ),
                  ),
                ),
                SizedBox(width: 20,),
                Container(
                  height: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 8,
                        child: Container(
                          child: Center(
                            child: Row(
                              children: <Widget>[
                                Text(
                                  seller.userName,
                                  style:
                                      TextStyle(color: Colors.white, fontSize: 18),
                                ),
                                SizedBox(width: 5,),
                                Text(
                                  seller.userSurname,
                                  style:
                                      TextStyle(color: Colors.white, fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                            child: Row(
                              children: <Widget>[
                                SmoothStarRating(
                                    allowHalfRating: true,
                                    onRated: (v) {},
                                    starCount: 5,
                                    rating: this.avgrating.toDouble(),
                                    size: 24.0,
                                    isReadOnly: true,
                                    filledIconData: Icons.star,
                                    halfFilledIconData: Icons.star_half,
                                    color: Colors.deepPurple,
                                    borderColor: Colors.deepPurple,
                                    spacing: 0.0),

                                    Padding(
                                      padding: const EdgeInsets.only(left:8.0),
                                      child: Text("${this.avgrating}/5",style: TextStyle(color: Colors.deepPurple,fontSize: 20),),
                                    ),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.fromLTRB(20, 5, 50, 5),
                  child: Text(
                    "Books",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                    textDirection: TextDirection.ltr,
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.fromLTRB(50, 5, 20, 5),
                  child: Text(
                    "Comments",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                    textDirection: TextDirection.ltr,
                  ),
                )
              ],
            ),
            Divider(
              thickness: 3,
              color: Colors.white60,
            ),
            Expanded(
              child: PageView(
                controller: controller,
                scrollDirection: Axis.horizontal,
                children: <Widget>[SellerBooksPage(bookfrom: seller,), SellerCommentsPage(sellingBook: seller,)],
              ),
            )
          ],
        ),
      ),
    );
  }
}
