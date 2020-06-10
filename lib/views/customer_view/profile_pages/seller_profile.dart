import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:Selfsahaf/views/customer_view/profile_pages/adress_page.dart';
import 'package:Selfsahaf/views/customer_view/profile_pages/history_page.dart';
import 'package:Selfsahaf/controller/user_controller.dart';
import 'package:Selfsahaf/views/customer_view/profile_pages/settings_page.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class SellerProfilePage extends StatefulWidget {
  // ExamplePage({ Key key }) : super(key: key);
  @override
  _SellerProfilePage createState() => new _SellerProfilePage();
}

class _SellerProfilePage extends State<SellerProfilePage> {
  AuthService userService = GetIt.I<AuthService>();
  String _name;
  @override
  void initState() {
    _name = userService.getUser().name + " " + userService.getUser().surname;
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
                Container(
                  height: 150,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 8,
                        child: Container(
                          child: Center(
                            child: Text(
                              _name,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                            child: Column(
                              children: <Widget>[
                                SmoothStarRating(
                                    allowHalfRating: true,
                                    onRated: (v) {},
                                    starCount: 5,
                                    rating: 3.8,
                                    size: 20.0,
                                    isReadOnly: true,
                                    filledIconData: Icons.star,
                                    halfFilledIconData: Icons.star_half,
                                    color: Colors.deepPurple,
                                    borderColor: Colors.deepPurple,
                                    spacing: 0.0),
                                    Text("3.82",style: TextStyle(color: Colors.deepPurple),),
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
                children: <Widget>[HistoryPage(), AdressesPage()],
              ),
            )
          ],
        ),
      ),
    );
  }
}
