import 'package:flutter/material.dart';
import 'package:selfsahaf/views/customer_view/products_pages/products_page.dart';
import 'package:selfsahaf/controller/product_services.dart';
import 'package:selfsahaf/views/customer_view/profile_pages/addAddress.dart';
class ProductsDialog extends StatefulWidget {
  ProductsDialog({Key key}) : super(key: key);

  @override
  _ProductsDialogState createState() => _ProductsDialogState();
}

class _ProductsDialogState extends State<ProductsDialog> {

  bool _productsShowDialog = true;

  
  @override
  Widget build(BuildContext context) {
    
    return AlertDialog(
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return (_productsShowDialog)
              ? Container(
                  width: 250,
                  height: 180,
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Do you want to be a seller?",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 25),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                          padding: EdgeInsets.fromLTRB(20, 30, 10, 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: InkWell(
                                  child: Container(
                                    color: Theme.of(context).primaryColor,
                                    padding: EdgeInsets.all(7.0),
                                    margin: EdgeInsets.all(5.0),
                                    child: Text(
                                      "No",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 30),
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left:8.0),
                                child: InkWell(
                                  child: Container(
                                    padding: EdgeInsets.all(7.0),
                                    margin: EdgeInsets.all(5.0),
                                    color: Theme.of(context).primaryColor,
                                    child: Text(
                                      "Yes",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 30),
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _productsShowDialog = false;
                                    });
                                  },
                                ),
                              )
                            ],
                          ))
                    ],
                  ),
                )
              : AddAddress(addType: 1,);
        },
      ),
    );
  }
}
