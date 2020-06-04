import 'package:flutter/material.dart';
import 'package:selfsahaf/views/customer_view/shopping_cart/shopping_cart.dart';

class NotificationsPage extends StatefulWidget {
  // ExamplePage({ Key key }) : super(key: key);
  @override
  _NotificationsPageState createState() => new _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Container(
              height: 50,
              child: Image.asset("images/logo_white/logo_white.png")),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ShoppingCart()),
                  );
                }),
          ],
        ),
      body: Center(
        child: Text("Badi"),
      ),
    );
  }
  
}