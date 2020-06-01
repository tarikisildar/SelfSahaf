import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:selfsahaf/views/admin_view/admin_main_page.dart';
import 'package:selfsahaf/views/app_guide.dart';
import 'package:selfsahaf/views/customer_view/main_view/main_page.dart';
import 'package:selfsahaf/controller/product_services.dart';
import 'package:selfsahaf/views/customer_view/main_view/page_classes/notification_pages/notifications.dart';
import 'package:selfsahaf/views/customer_view/main_view/page_classes/search_pages/search_page.dart';
import 'package:selfsahaf/views/customer_view/products_pages/add_book.dart';
import 'package:selfsahaf/views/customer_view/profile_pages/account_profile.dart';
import 'package:selfsahaf/views/registration/login.dart';
import 'package:selfsahaf/controller/user_controller.dart';

import 'views/registration/signup.dart';
import 'package:selfsahaf/controller/book_controller.dart';


void setupServiseLocator() {
  GetIt.I.registerLazySingleton(() => BookService());
  GetIt.I.registerLazySingleton(() => ProductService());
  GetIt.I.registerLazySingleton(() => AuthService());
}

void main() {
  setupServiseLocator();
  runApp(SelfSahaf());
}

class SelfSahaf extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SelfSahaf',
      theme: ThemeData(
        primaryColor: Color(0xffe65100),
        accentColor: Color(0xff833a),
        textSelectionColor: Color(0xffac1900),
        canvasColor: Color(0xffe65100),
        cardColor: Color(0xffe65100),

        // Butun uygulamadaki font ailesi
        fontFamily: 'Roboto',

        // Figmadaki sayfa tasarımlarına bakarak hangisinin kullanmanilmasi gerektigine bakman lazim kanka
        // Bunlari istedigin bir font size ile kullanmak icin copyWith metodunu kullanabilirsin, meselam:
        // Theme.of(context).textTheme.title.copyWith(fontSize: 18.0)
        textTheme: TextTheme(
          title: TextStyle(
              color: Color.fromRGBO(47, 19, 8, 1),
              fontWeight: FontWeight.w700), // Montserrat bold
          display1: TextStyle(
              color: Color.fromRGBO(47, 19, 8, 1),
              fontWeight: FontWeight.w500), // Montserrat medium
          body1: TextStyle(
              color: Color.fromRGBO(47, 19, 8, 1), fontWeight: FontWeight.w600),
          body2: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          //white body elements
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => LoginPage(),
        '/signup': (context) => Signup(),
        '/guider': (context) => Guide(),
        '/mainPage': (context) => MainPage(),
        '/adminMain': (context) => AdminMainPage(),
        '/searchPage': (context) => SearchPage(),
        '/notifications': (context) => NotificationsPage(),
        '/profilePage': (context) => AccountProfilePage(),
        '/addbooks': (context) => AddBook(),
      },
    );
  }
}
