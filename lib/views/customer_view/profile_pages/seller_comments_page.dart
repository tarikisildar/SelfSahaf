import 'package:Selfsahaf/views/errors/error_dialog.dart';
import 'package:Selfsahaf/controller/rating_controller.dart';
import 'package:Selfsahaf/models/book.dart';
import 'package:Selfsahaf/models/rating.dart';
import 'package:Selfsahaf/views/errors/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:Selfsahaf/controller/user_controller.dart';
import 'package:Selfsahaf/models/address.dart';
import 'package:Selfsahaf/views/customer_view/profile_pages/address_widget.dart';
import 'package:Selfsahaf/views/customer_view/profile_pages/addAddress.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class SellerCommentsPage extends StatefulWidget {
  Book sellingBook;
  SellerCommentsPage({this.sellingBook});
  @override
  _SellerCommentsPage createState() => new _SellerCommentsPage();
}

class _SellerCommentsPage extends State<SellerCommentsPage> {
  Book sellingBook;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  RatingService _ratingService = GetIt.I<RatingService>();
  List<Rating> allRatings;
  @override
  void initState() {
    this.sellingBook = widget.sellingBook;
    _getRatings(context);
  }

  _getRatings(BuildContext context) async {
    _ratingService.getRatings(sellingBook.sellerID).then((value) {
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
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: RefreshIndicator(
            onRefresh: () => _getRatings(context),
            key: _refreshIndicatorKey,
            child: ListView(
              children: <Widget>[
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, index) {
                    return (allRatings == null)
                        ? Center(
                            child: Text(
                              "No Comments Exists",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : Container(
                          height: 75,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16) 
                          ),
                          child: Column(
                            children: <Widget>[
                              Text(allRatings[index].comment),
                              SmoothStarRating(
                                    allowHalfRating: true,
                                    onRated: (v) {},
                                    starCount: 5,
                                    rating: allRatings[index].rating,
                                    size: 20.0,
                                    isReadOnly: true,
                                    filledIconData: Icons.star,
                                    halfFilledIconData: Icons.star_half,
                                    color: Colors.deepPurple,
                                    borderColor: Colors.deepPurple,
                                    spacing: 0.0),
                            ],
                          ),
                        );
                  },
                  itemCount: (allRatings == null) ? 1 : allRatings.length,
                ),
                SizedBox(height: 80,) 
              ],
            )));
  }
}
