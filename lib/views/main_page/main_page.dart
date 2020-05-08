import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:selfsahaf/views/app_guide.dart';
import 'package:selfsahaf/views/page_classes/main_page/book_card.dart';
import 'package:selfsahaf/views/page_classes/main_page/home_page_carousel.dart';
import 'package:selfsahaf/views/page_classes/main_page/sahaf_drawer.dart';
import 'package:selfsahaf/views/page_classes/notification_pages/notifications.dart';
import 'package:selfsahaf/views/page_classes/search_pages/search_page.dart';
import 'package:selfsahaf/views/profile_pages/account_profile.dart';
import 'package:selfsahaf/views/profile_pages/profile_page.dart';
import 'package:selfsahaf/controller/user_controller.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
  int _prevIndex;
  int _index = 0;
  List<Widget> _pages = [
      MainPage(),
      SearchPage(),
      NotificationsPage(),
      AccountProfilePage(),
    ];
  AuthService get userService=>GetIt.I<AuthService>(); 
  bool _loading=true;
  @override
  void initState() {

_fetchData();
  _pages  = [MainPage(), SearchPage(), NotificationsPage(), AccountProfilePage()];
  }
  _fetchData()async{
   userService.initUser().then((e){
     setState(() {
       _loading=false;
     });
   });
  
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
        appBar: AppBar(
          title: Container(height: 50,child: Image.asset("images/logo_white/logo_white.png")),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  print("shopping");
                }),
          ],
        ),
        drawer:(_loading)? CircularProgressIndicator() : SahafDrawer(),
        body:(_loading)? CircularProgressIndicator() : ListView(
          children: <Widget>[
            HomePageCarousel(),
            BookCard(),
          ],
        ));
  }

  _changeIndex(int i) {
    _prevIndex = _index;
    _index = i;
    setState(() {});
  }
}
