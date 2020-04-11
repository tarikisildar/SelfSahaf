import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:selfsahaf/views/page_classes/book_card.dart';
import 'package:selfsahaf/views/page_classes/home_page_carousel.dart';
import 'package:selfsahaf/views/page_classes/account_profile.dart';
import 'package:selfsahaf/views/page_classes/notifications.dart';
import 'package:selfsahaf/views/page_classes/sahaf_drawer.dart';
import 'package:selfsahaf/views/page_classes/search_page.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
       
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
        body:ListView(
          children: <Widget>[
            HomePageCarousel(),
            BookCard(),
          ],
        )
        );
  }
}
