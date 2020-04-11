import 'package:flutter/material.dart';
import 'package:selfsahaf/views/admin_pages/admin_search.dart';

class AdminDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 100.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(192, 72, 46, 1),
        ),
        child: Column(
          children: <Widget>[
            Container(
              height: 100,
              padding: EdgeInsets.only(top: 50, bottom: 10),
              margin: EdgeInsets.only(left: 50, top: 0,right:50),
              child: Center(
                    child: Image.asset('images/selfadmin_logo/selfadmin.png'),
                  ),
              
            ),
            InkWell(
              child: ListTile(
                contentPadding: EdgeInsets.only(top:10,left:20),
                  leading: Icon(Icons.search, color: Colors.white),
                  title: Text(
                    "Search \nBooks/Users",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminSearch()),
                )
              },
            ),
          
            InkWell(
              child: ListTile(
                contentPadding: EdgeInsets.only(top:10,left:20),
                  leading: Icon(
                    Icons.local_shipping,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Shipping Companies",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )),
              onTap: () => {},
            ),
            InkWell(
              
              child: ListTile(
                contentPadding: EdgeInsets.only(top:10,left:20),
                  leading: Icon(Icons.edit, color: Colors.white),
                  title: Text(
                    "Edit Categories",
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
