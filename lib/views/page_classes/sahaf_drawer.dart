import 'package:flutter/material.dart';

class SahafDrawer extends StatelessWidget {
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
                      Text('İsim Soyisim',
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
                    "Hesabim",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )
                  ),
              onTap: () => {},
            ),
            InkWell(
              child: ListTile(
                  leading: Icon(
                    Icons.category,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Kategoriler",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )),
              onTap: () => {},
            ),
            InkWell(
              child: ListTile(
                  leading: Icon(Icons.settings, color: Colors.white),
                  title: Text(
                    "Ayarlar",
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
