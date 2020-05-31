import 'package:flutter/material.dart';
import 'package:selfsahaf/models/book.dart';
import 'package:selfsahaf/views/products_pages/product_card.dart';
import 'package:selfsahaf/views/shopping_cart/order_address.dart';

class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() {
    return _ShoppingCartState();
  }
}

class _ShoppingCartState extends State<ShoppingCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
            height: 50, child: Image.asset("images/logo_white/logo_white.png")),
        leading: InkWell(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: <Widget>[
                Text("SDASD"),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Container(
            width: MediaQuery.of(context).size.width - 32,
            height: 60,
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  side: BorderSide(color: Color.fromRGBO(230, 81, 0, 1))),
              color: Colors.white,
              onPressed: () async {
                //@TODO : degistir bunu
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrderAddress()),
                );
              },
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 15,
                    child: Text(
                      "Checkout",
                      style: TextStyle(
                          color: Color.fromRGBO(230, 81, 0, 1), fontSize: 20),
                    ),
                  ),
                  Expanded(
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Color.fromRGBO(230, 81, 0, 1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
