
import 'package:flutter/material.dart';
import 'package:selfsahaf/views/admin_pages/admin_main_page.dart';
import 'package:selfsahaf/views/admin_pages/admin_search.dart';
import 'package:selfsahaf/views/main_page/main_page.dart';
import 'package:selfsahaf/views/page_classes/add_book.dart';
import 'package:selfsahaf/views/registration/login.dart';
import 'package:selfsahaf/views/profile_pages/profile.dart';


void main() => runApp(SelfSahaf());

class SelfSahaf extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SelfSahaf',
      theme: ThemeData(
        primaryColor: Color(0xffe65100),
        accentColor: Color(0xff833a),
        textSelectionColor: Color(0xffac1900),
        
      
      
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
              color: Color.fromRGBO(47, 19, 8, 1),
              fontWeight: FontWeight.w600),
          body2: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600), //white body elements
          
        ),
      ),
      debugShowCheckedModeBanner: false,
      
      
      initialRoute: '/',
      
      routes: <String, WidgetBuilder>{
        '/': (context) => LoginPage(),
        '/mainPage' : (context) => MainPage(),
        '/addBook' : (context) => AddBook(),
         '/profil':(context)=>ProfilePage(),
      },
    );
  }
}
