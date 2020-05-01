import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:selfsahaf/views/main_page/main_page.dart';
import 'package:selfsahaf/views/page_classes/main_page/book_card.dart';
import 'package:selfsahaf/views/page_classes/main_page/home_page_carousel.dart';
import 'package:selfsahaf/views/page_classes/main_page/sahaf_drawer.dart';
import 'package:selfsahaf/views/page_classes/notification_pages/notifications.dart';
import 'package:selfsahaf/views/page_classes/search_pages/search_page.dart';
import 'package:selfsahaf/views/profile_pages/account_profile.dart';
import 'package:selfsahaf/views/profile_pages/profile_page.dart';
import 'package:selfsahaf/controller/user_controller.dart';

class Guide extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GuideState();
  }
}

class _GuideState extends State<Guide> {
  int _prevIndex;
  int _index = 0;
  List<Widget> _pages = [
    MainPage(),
    SearchPage(),
    NotificationsPage(),
    AccountProfilePage(),
  ];
  AuthService get userService => GetIt.I<AuthService>();
  bool _loading = true;
  @override
  void initState() {
    _fetchData();
    _pages = [
      MainPage(),
      SearchPage(),
      NotificationsPage(),
      AccountProfilePage()
    ];
  }

  _fetchData() async {
    userService.initUser().then((e) {
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        elevation: 7,
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xffe65100),
          ),
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  InkWell(
                    child: _index == 0
                        ? Icon(
                            Icons.home,
                            size: 35,
                            color: Colors.white,
                          )
                        : Icon(
                            Icons.home,
                            size: 30,
                            color: Colors.white,
                          ),
                    onTap: () => _changeIndex(0),
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
                    onTap: () => _changeIndex(1),
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
                    onTap: () => _changeIndex(2),
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
                    onTap: () => _changeIndex(3),
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
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Container(
            height: 50, child: Image.asset("images/logo_white/logo_white.png")),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                print("shopping");
              }),
        ],
      ),
      drawer: (_loading) ? CircularProgressIndicator() : SahafDrawer(),
      body: _pages[_index],
    );
  }

  _changeIndex(int i) {
    _prevIndex = _index;
    _index = i;
    setState(() {});
  }
}
