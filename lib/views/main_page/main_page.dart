import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:selfsahaf/views/page_classes/book_card.dart';
import 'package:selfsahaf/views/page_classes/home_page_carousel.dart';
import 'package:selfsahaf/views/page_classes/account_profile.dart';
import 'package:selfsahaf/views/page_classes/notifications.dart';
import 'package:selfsahaf/views/page_classes/sahaf_drawer.dart';
import 'package:selfsahaf/views/page_classes/search_page.dart';
import 'package:selfsahaf/views/profile_pages/profile.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
  int _index = 0;
  List<Widget> _pages = [MainPage(), SearchPage(), NotificationsPage(), AccountProfilePage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomAppBar(
          elevation: 7,
          child: Container(
            height: 50,
            color: Color(0xffe65100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 30,
                    ),
                    Column(
                      children: <Widget>[
                        InkWell(
                          child: _index == 0
                              ? Icon(
                                  Icons.home,
                                  size: 25,
                                  color: Colors.white,
                                )
                              : Icon(
                                  Icons.home,
                                  size: 30,
                                  color: Colors.white,
                                ),
                          onTap: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainPage()))
                          },
                        ),
                        _index == 0
                            ? Text(
                                "Ana Sayfa",
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold),
                              )
                            : SizedBox(),
                      ],
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Column(
                      children: <Widget>[
                        InkWell(
                          child: _index == 1
                              ? Icon(
                                  Icons.search,
                                  size: 25,
                                  color: Colors.white,
                                )
                              : Icon(
                                  Icons.search,
                                  size: 30,
                                  color: Colors.white,
                                ),
                          onTap: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchPage()))
                          },
                        ),
                        _index == 1
                            ? Text(
                                "Arama",
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold),
                              )
                            : SizedBox(),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        InkWell(
                          child: _index == 2
                              ? Icon(
                                  Icons.notifications,
                                  size: 25,
                                  color: Colors.white,
                                )
                              : Icon(
                                  Icons.notifications_none,
                                  size: 30,
                                  color: Colors.white,
                                ),
                          onTap: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NotificationsPage()))
                          },
                        ),
                        _index == 2
                            ? Text(
                                "Bildirimler",
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold),
                              )
                            : SizedBox(),
                      ],
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Column(
                      children: <Widget>[
                        InkWell(
                          child: _index == 3
                              ? Icon(
                                  Icons.person,
                                  size: 25,
                                  color: Colors.white,
                                )
                              : Icon(
                                  Icons.person_outline,
                                  size: 30,
                                  color: Colors.white,
                                ),
                          onTap: () => {
                           Navigator.push(context, MaterialPageRoute(builder: ( context) => ProfilePage()))
                          },
                        ),
                        _index == 3
                            ? Text(
                                "Profilim",
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold),
                              )
                            : SizedBox(),
                      ],
                    ),
                    SizedBox(
                      width: 30,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        appBar: AppBar(
          title: Image.asset("images/logo_white/logo_white.png"),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  print("shopping");
                }),
          ],
        ),
        drawer: SahafDrawer(),
        body: ListView(
          children: <Widget>[
            HomePageCarousel(),
            BookCard(),
          ],
        ));
  }

  _changeIndex(int i) {
    _index = i;
    setState(() {

    });
  }
}
