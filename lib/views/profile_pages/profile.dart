import 'package:flutter/material.dart';
import 'package:selfsahaf/views/profile_pages/adressPage.dart';
import 'package:selfsahaf/views/profile_pages/historyPage.dart';

class ProfilePage extends StatefulWidget {
  // ExamplePage({ Key key }) : super(key: key);
  @override
  _ProfilePage createState() => new _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  String _name = "Yavuz Güler";
  List<Widget> _pages = [AdressesPage(), HistoryPage()];
  var controller=PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("images/logo_white/logo_white.png"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                print("settings");
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
                  height: 200,
                  width: 200,
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
                  width: 150,
                  height: 50,
                  margin: EdgeInsets.fromLTRB(20, 20, 20, 100),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  child: Center(
                    child: Text(_name),
                  ),
                ),
              ],
            )),
             
              Row(
                  mainAxisAlignment: MainAxisAlignment.center ,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.fromLTRB(20, 5, 50,5),
              child: Text("History",textAlign: TextAlign.center, style: TextStyle(fontSize: 20,color: Colors.white ),textDirection: TextDirection.ltr,),
            ),
            Container(
              alignment: Alignment.centerRight,
             padding: EdgeInsets.fromLTRB(50, 5, 20,5),
             child: Text("Adresses",textAlign: TextAlign.center, style: TextStyle(fontSize: 20,color: Colors.white ),textDirection: TextDirection.ltr,),
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
                  children: <Widget>[
                     HistoryPage(),
                      AdressesPage()
                     
                  ],
                ),
            )
          ],
        ),
      ),
    );
  }
}
