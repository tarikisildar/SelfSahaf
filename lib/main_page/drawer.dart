import 'package:flutter/material.dart';

class MainPageDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(47, 19, 8, 1),
      ),
      child: ListView(
        children: <Widget>[
          Container(
            height: 200,
            child: DrawerHeader(
              padding: EdgeInsets.only(top: 0, bottom: 0),
              margin: EdgeInsets.only(left: 8, top: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      child: Image.asset('images/logo_white/logo_white.png'),
                      height: 150,
                      width: 200),
                  Padding(
                    padding: const EdgeInsets.only(left: 13.0),
                    child: Text('İsim Soyisim',
                        style: Theme.of(context)
                            .textTheme
                            .body2
                            .copyWith(fontSize: 24)),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
            ),
          ),
          new SizedBox(
            height: 10.0,
            child: new Center(
              child: new Container(
                margin: new EdgeInsetsDirectional.only(start: 0.0, end: 0.0),
                height: 5.0,
                color: Colors.red,
              ),
            ),
          ),

          new ListWidgetElements(
              Icon(
                Icons.account_box,
                size: 40.0,
                color: Colors.white,
              ),
              "Hesabım"),
              new ListWidgetElements(
              Icon(Icons.view_headline ,size:40.0, color: Colors.white), "Katagoriler"),
          new ListWidgetElements(
              Icon(Icons.build,size:40.0, color: Colors.white), "Ayarlar")
        ],
      ),
    );
  }
}

class ListWidgetElements extends StatelessWidget {
  Icon icon;

  String text;
  ListWidgetElements(
    this.icon,
    this.text,
  ) {
    this.icon = icon;
    this.text = text;
  }
  @override
  Widget build(BuildContext context) {

    return Container(
      child: ListTile(
        leading: icon,
        title: Padding(
          child: Text(text,
              style:
                  Theme.of(context).textTheme.body2.copyWith(fontSize: 20.0)),
          padding: EdgeInsets.only(left: 8.0),
        ),
        onTap: () {},
      ),
    );
  }
}
