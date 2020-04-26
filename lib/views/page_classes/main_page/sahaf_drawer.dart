import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:selfsahaf/controller/user_controller.dart';
import 'package:selfsahaf/views/products_pages/productsDialog.dart';
import 'package:selfsahaf/views/products_pages/products_page.dart';
class SahafDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SahafDrawer();
  }
}

class _SahafDrawer extends State<SahafDrawer> {
 AuthService userService=GetIt.I<AuthService>();
 bool seller=false;
 @override
  void initState() {
    if(userService.getUser().role=="ROLE_ADMIN" || userService.getUser().role=="ROLE_SELLER")
      setState(() {
        seller=true;
      });
  }
 
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 100.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(192, 72, 46, 1),
        ),
        child: ListView(
          children: <Widget>[
            Container(
              height: 200,
              child: DrawerHeader(
                padding: EdgeInsets.only(top: 0, bottom: 0),
                margin: EdgeInsets.only(left: 8, top: 0),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          child:
                              Image.asset('images/logo_white/logo_white.png'),
                          height: 150,
                          width: 200),
                      Text(userService.getUser().name +" "+ userService.getUser().surname ,
                          style: Theme.of(context)
                              .textTheme
                              .body2
                              .copyWith(fontSize: 24)),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
              ),
            ),
            Divider(
              thickness: 2,
              color: Colors.white60,
            ),
            InkWell(
              child: ListTile(
                  leading: Icon(Icons.person, color: Colors.white),
                  title: Text(
                    "My Account",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )),
              onTap: () => {},
            ),
            InkWell(
                child: ListTile(
                    leading: Icon(
                      Icons.category,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Categories",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )),
                onTap: () {}),
            InkWell(
              child: ListTile(
                  leading: Icon(
                    Icons.attach_money,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Products",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )),
              onTap: () { 
                return (seller)? Navigator.push(context, MaterialPageRoute(builder:(context)=>ProductsPage() )) :showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return ProductsDialog();
                    });
              },
            ),
            InkWell(
              child: ListTile(
                  leading: Icon(Icons.settings, color: Colors.white),
                  title: Text(
                    "Settings",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )),
              onTap: () => {},
            )
          ],
        ),
      ),
    );
  }
}
