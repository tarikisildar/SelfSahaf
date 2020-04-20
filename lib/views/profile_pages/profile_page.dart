import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:selfsahaf/views/profile_pages/adress_page.dart';
import 'package:selfsahaf/views/profile_pages/history_page.dart';
import 'package:selfsahaf/views/profile_pages/settings_page.dart';
import 'package:selfsahaf/controller/user_controller.dart';

class ProfilePage extends StatefulWidget {
  // ExamplePage({ Key key }) : super(key: key);
  @override
  _ProfilePage createState() => new _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  AuthService userService= GetIt.I<AuthService>();
  String _name;
@override
void initState() { 
  _name=userService.getUser().name+" "+ userService.getUser().surname;
  
}
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
                Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SettingsPage()));
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
                Expanded(child: 
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
                )),
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
