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
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  OrderService get orderService => GetIt.I<OrderService>();
  List<Order> allorders;
  bool _isloading = true;

  _fetchData() async {
    _refresh();
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
            height: 50, child: Image.asset("images/logo_white/logo_white.png")),
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
      body:  RefreshIndicator(
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
                                  "No Books Sold",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
                                )),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(35.0),
                                child: Center(
                                    child: Text(
                                  allorders[index].price.toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
                                )),
                              );
                  }))
    );
  }
}
