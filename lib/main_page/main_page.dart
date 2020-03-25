import 'package:flutter/material.dart';
import 'package:selfsahaf/page_classes/BookCard.dart';
import 'package:selfsahaf/page_classes/HomePageCarousel.dart';
import 'package:selfsahaf/page_classes/account_profile.dart';
import 'package:selfsahaf/page_classes/notifications.dart';
import 'package:selfsahaf/page_classes/sahaf_drawer.dart';
import 'package:selfsahaf/page_classes/search_page.dart';


class MainPage extends StatefulWidget{
  
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
            child: Container(
          height: 50,
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
                                size: 35,
                                color: Color(0xffe65100),
                              )
                            : Icon(
                                Icons.home,
                                size: 40,
                                color: Color(0xffe65100),
                              ),
                        onTap: () => {},
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
                                size: 35,
                                color: Color(0xffe65100),
                              )
                            : Icon(
                                Icons.search,
                                size: 40,
                                color: Color(0xffe65100),
                              ),
                        onTap:() => {},
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
                                size: 35,
                                color: Color(0xffe65100),
                              )
                            : Icon(
                                Icons.notifications_none,
                                size: 40,
                                color: Color(0xffe65100),
                              ),
                        onTap: () => {},
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
                                size: 35,
                                color: Color(0xffe65100),
                              )
                            : Icon(
                                Icons.person_outline,
                                size: 40,
                                color: Color(0xffe65100),
                              ),
                        onTap: () =>{},
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
          new IconButton(icon: Icon(Icons.search) , onPressed: (){
            print("search");
          }),
          new IconButton(icon: Icon(Icons.shopping_cart) , onPressed: (){
            print("shoping");
          }),
        ],
      ),
      drawer: SahafDrawer(
      ),
      body: new ListView(
        children: <Widget>[
          HomePageCarousel(),
          Padding(padding: EdgeInsets.all(0.1)),
          Container(height:320,child: BookCard(),)
        ],
      )
    );
  }

}
 