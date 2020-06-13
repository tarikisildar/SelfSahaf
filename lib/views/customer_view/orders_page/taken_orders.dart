import 'package:Selfsahaf/controller/order_service.dart';
import 'package:Selfsahaf/models/order.dart';
import 'package:Selfsahaf/views/customer_view/shopping_cart/shopping_cart.dart';
import 'package:Selfsahaf/views/errors/error_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class TakenOrders extends StatefulWidget {
  @override
  _TakenOrdersState createState() => _TakenOrdersState();
}

class _TakenOrdersState extends State<TakenOrders> {
  String markedAs;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  OrderService get orderService => GetIt.I<OrderService>();
  List<Order> allorders;
  bool _isloading = true;

  _fetchData() async {
    _refresh();
  }

  _markDialog(BuildContext context, Order order) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).primaryColor,
            title:
                Text("Mark Order As:", style: TextStyle(color: Colors.white)),
            content: DropdownButton<String>(
              hint: Text(
                "Select Condition",
                style: TextStyle(color: Colors.white),
              ),
              items: ["SHIPPING", "CONFIRMED", "DELIVERED"]
                  .map((String dropdownItem) {
                return DropdownMenuItem<String>(
                  value: dropdownItem,
                  child: Text(
                    dropdownItem,
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }).toList(),
              onChanged: (String newValueSelected) {
                setState(() {
                  this.markedAs = newValueSelected;
                });
              },
              value: this.markedAs,
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  if (markedAs == null) {
                    print("please mark order.");
                  } else {
                    print(markedAs);
                    Navigator.of(context).pop();
                  }
                },
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  "Apply",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            ],
          );
        });
  }

  Future<Null> _refresh() {
    return orderService.getTakenOrders().then((e) {
      if (!e.error) {
        setState(() {
          _isloading = false;
          this.allorders = e.data;
        });
      } else {
        setState(() {
          _isloading = false;
          this.allorders = e.data;
        });
        ErrorDialog().showErrorDialog(context, "Error!", e.errorMessage);
      }
    });
  }

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

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
        body: RefreshIndicator(
            onRefresh: () => _refresh(),
            key: _refreshIndicatorKey,
            child: new ListView.builder(
                itemCount: (allorders == null) ? 1 : allorders.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return (_isloading)
                      ? CircularProgressIndicator()
                      : (allorders == null)
                          ? Padding(
                              padding: const EdgeInsets.all(35.0),
                              child: Center(
                                  child: Text(
                                "No Books Waiting For Acceptance",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25),
                              )),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Container(
                                  height: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 8,
                                          child: Column(
                                            children: <Widget>[
                                              Expanded(
                                                flex: 1,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 8,
                                                      child: Text(
                                                        "OrderID: ",
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 12,
                                                      child: Text(
                                                        allorders[index]
                                                            .shippingInfo
                                                            .shippingInfoID
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 8,
                                                      child: Text(
                                                        "Book's Name: ",
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 12,
                                                      child: Text(
                                                        allorders[index]
                                                            .product
                                                            .name,
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 8,
                                                      child: Text(
                                                        "Author's Name: ",
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 12,
                                                      child: Text(
                                                        allorders[index]
                                                            .product
                                                            .authorName,
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 8,
                                                      child: Text(
                                                        "Price: ",
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 12,
                                                      child: Text(
                                                        allorders[index]
                                                            .product
                                                            .price
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 8,
                                                      child: Text(
                                                        "Shipping Company: ",
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 12,
                                                      child: Text(
                                                        allorders[index]
                                                            .shippingInfo
                                                            .shippingcompany
                                                            .companyName,
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 8,
                                                      child: Text(
                                                        "Buyer Name: ",
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 12,
                                                      child: Text(
                                                        allorders[index]
                                                            .buyer
                                                            .name,
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 8,
                                                      child: Text(
                                                        "Buyer Phone Number: ",
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            fontSize: 10),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 12,
                                                      child: Text(
                                                        allorders[index]
                                                            .buyer
                                                            .phoneNumber,
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: GestureDetector(
                                            onTap: () {
                                              _markDialog(context, allorders[index]);
                                            },
                                            child: Container(
                                              child: Icon(
                                                Icons.arrow_forward_ios,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            );
                })));
  }
}
