import 'package:Selfsahaf/controller/order_service.dart';
import 'package:Selfsahaf/models/order.dart';
import 'package:Selfsahaf/views/customer_view/shopping_cart/shopping_cart.dart';
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
  OrderService get productService => GetIt.I<OrderService>();
  List<Order> allorders;
  bool _isloading = true;

  _fetchData() async {
    _refresh().then((value) {
      setState(() {
        _isloading = false;
      });
    });
  }

  Future<Null> _refresh() {
    return productService.getTakenOrders().then((e) {
      setState(() {
        print(e.length);
        _isloading = false;
        this.allorders = e;
      });
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
      body: Container(
          color: Theme.of(context).primaryColor,
          child: RefreshIndicator(
              onRefresh: () => _refresh(),
              key: _refreshIndicatorKey,
              child: new ListView.builder(
                  itemCount: allorders.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    if (_isloading) {
                      return CircularProgressIndicator();
                    }
                    if (allorders[0] == null) {
                      return Padding(
                        padding: const EdgeInsets.all(35.0),
                        child: Center(
                            child: Text(
                          "No Books on Sale",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        )),
                      );
                    }
                    else{
                      return Text("${allorders.length}");
                    }
                  }))),
    );
  }
}
