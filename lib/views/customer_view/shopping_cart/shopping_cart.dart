import 'package:Selfsahaf/controller/cart_service.dart';
import 'package:Selfsahaf/models/cart_model.dart';
import 'package:Selfsahaf/views/errors/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:Selfsahaf/models/book.dart';
import 'package:Selfsahaf/views/customer_view/products_pages/product_card.dart';
import 'package:Selfsahaf/views/customer_view/shopping_cart/order_address.dart';
import 'package:Selfsahaf/models/api_response.dart';
import 'package:get_it/get_it.dart';

class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() {
    return _ShoppingCartState();
  }
}

class _ShoppingCartState extends State<ShoppingCart> {
  CartService get _cartService => GetIt.I<CartService>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  List<CartModel> _cartList;
  bool _loading = true;
  Future<Null> _refresh(BuildContext context) {
    setState(() {
      _loading = true;
    });
    _cartService.getCart().then((value) {
      setState(() {
        if (!value.error) {
          this._cartList = value.data;
        } else {
          ErrorDialog().showErrorDialog(context, "Error", value.errorMessage);
        }
        _loading = false;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _refresh(context);
  }

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
          color: Color(0xffe65100),
          padding: const EdgeInsets.all(16.0),
          child: (_loading)
              ? Container(
                  color: Colors.transparent,
                  child: Center(
                      child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  )))
              : RefreshIndicator(
                  onRefresh: () async {
                    _refresh(context);
                  },
                  key: _refreshIndicatorKey,
                  child: (_cartList == null)
                      ? ListView(
                          children: <Widget>[
                            Center(
                              child: Text(
                                "No product in cart.",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25),
                              ),
                            )
                          ],
                        )
                      : ListView.builder(
                          itemCount: _cartList.length,
                          itemBuilder: (_, int index) {
                            return Dismissible(
                              key: ValueKey(_cartList[index].productID),
                              child: ProductCard(
                                bookName: _cartList[index].book.name,
                                authorName: _cartList[index].book.authorName,
                                publisherName: _cartList[index].book.publisher,
                                price: "${_cartList[index].price}",
                                productID: _cartList[index].productID,
                                sellerID: _cartList[index].sellerID,
                              ),
                              direction: DismissDirection.horizontal,
                              onDismissed: (direction) {
                                print("sa");
                              },
                              confirmDismiss: (direction) async {
                                //right to left for information
                                if (direction == DismissDirection.endToStart) {
                                  print("sondan basa");
                                  return false;
                                }
                                //left to right for delete

                                final result = await showDialog(
                                    context: context,
                                    builder: (_) {
                                      return AlertDialog(
                                        content: Text(
                                            "Confirm if you want to delete ${_cartList[index].book.name}"),
                                        title: Text(
                                            "Do yo want to delete the book?"),
                                        actions: <Widget>[
                                          FlatButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                side: BorderSide(
                                                    color: Color.fromRGBO(
                                                        230, 81, 0, 1))),
                                            child: Text(
                                              "DELETE",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            color:
                                                Theme.of(context).primaryColor,
                                            onPressed: () {
                                              _cartService
                                                  .deleteItemFromCart(
                                                      _cartList[index]
                                                          .productID)
                                                  .then((value) {
                                                if (!value.error) {
                                                  setState(() {
                                                    _cartList.removeAt(index);
                                                  });
                                                  if (_cartList.length == 0) {
                                                    setState(() {
                                                      _cartList = null;
                                                    });
                                                  }
                                                  Navigator.of(context)
                                                      .pop(true);
                                                } else
                                                  Navigator.of(context)
                                                      .pop(false);
                                              });
                                            },
                                          ),
                                          FlatButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                side: BorderSide(
                                                    color: Color.fromRGBO(
                                                        230, 81, 0, 1))),
                                            child: Text(
                                              "CANCEL",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            color:
                                                Theme.of(context).primaryColor,
                                            onPressed: () {
                                              Navigator.of(context).pop(false);
                                            },
                                          ),
                                        ],
                                      );
                                    });
                                if (result == null) return false;
                                print(result);
                                return result;
                              },
                              //sağdan sola
                              secondaryBackground: Container(
                                  padding: EdgeInsets.all(12),
                                  margin: EdgeInsets.all(8),
                                  child: Align(
                                      child: Icon(Icons.edit,
                                          color: Colors.white, size: 50),
                                      alignment: Alignment.centerRight),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(20.0),
                                  )),
                              //soldan sağa
                              background: Container(
                                margin: EdgeInsets.all(8),
                                padding: EdgeInsets.only(left: 16),
                                child: Align(
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                  alignment: Alignment.centerLeft,
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                            );
                          },
                        ))),
      floatingActionButton: GestureDetector(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 6,
                  blurRadius: 9,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            width: MediaQuery.of(context).size.width - 32,
            height: 60,
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  ),
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
