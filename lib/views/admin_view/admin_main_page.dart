import 'package:flutter/material.dart';
import 'package:Selfsahaf/views/admin_view/admin_drawer.dart';

class AdminMainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AdminMainPageState();
  }
}

class _AdminMainPageState extends State<AdminMainPage> {
  int _userCount = 2000, _ordersCount = 3000, _sellerCount = 1000;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: Container(
            height: 22,
            child: Image.asset("images/selfadmin_logo/selfadmin.png"),
          ),
        ),
        drawer: AdminDrawer(),
        body: Center(
            child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "$_userCount",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      child: Text(
                        "Users Exist",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "$_ordersCount",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      child: Text(
                        "Orders Given",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "$_sellerCount",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      child: Text(
                        "Sahafs Exist",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )));
  }
}
