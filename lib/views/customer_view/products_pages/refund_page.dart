import 'package:Selfsahaf/models/order.dart';
import 'package:Selfsahaf/views/registration/input_field.dart';
import 'package:flutter/material.dart';

class RefundPage extends StatefulWidget {
  Order ourOrder;
  RefundPage({@required this.ourOrder});
  @override
  _RefundPageState createState() => _RefundPageState();
}

class _RefundPageState extends State<RefundPage> {
  String refundreasonValidation(String reason) {
    if (reason.length < 60) {
      return "Please explain your reason in detail.";
    } else
      return null;
  }

  final _refundreasonController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
            height: 50, child: Image.asset("images/logo_white/logo_white.png")),
      ),
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Container(
                  child: Center(
                    child: Text(
                      "Refund for: " + widget.ourOrder.product.name,
                      style: TextStyle(color: Colors.white,fontSize: 25),
                    ),
                  ),
                ),
              ),
              Divider(thickness: 1.5,color: Colors.white,),
              SizedBox(height: 10,),
              Container(
                child: TextFormField(
                  maxLines: 8,
                  minLines: 3,
                  controller: _refundreasonController,
                  validator: refundreasonValidation,
                  cursorColor: Colors.orange,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      errorStyle: TextStyle(color: Colors.white),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      labelText: "Reason for refunding",
                      labelStyle: TextStyle(color: Colors.white),
                      focusedBorder: OutlineInputBorder(
                          gapPadding: 2.0,
                          borderSide:
                              BorderSide(color: Colors.white, width: 3.0),
                          borderRadius: new BorderRadius.circular(16.0)),
                      enabledBorder: new OutlineInputBorder(
                        gapPadding: 2.0,
                        borderRadius: new BorderRadius.circular(16.0),
                        borderSide: new BorderSide(
                          color: Colors.white,
                          width: 3.0,
                        ),
                      ),
                      errorBorder: new OutlineInputBorder(
                        gapPadding: 2.0,
                        borderRadius: new BorderRadius.circular(16.0),
                        borderSide: new BorderSide(
                          color: Colors.deepPurple,
                          width: 3.0,
                        ),
                      ),
                      focusedErrorBorder: new OutlineInputBorder(
                        gapPadding: 2.0,
                        borderRadius: new BorderRadius.circular(16.0),
                        borderSide: new BorderSide(
                          color: Colors.deepPurple,
                          width: 3.0,
                        ),
                      )),
                ),
              ),
              SizedBox(height: 20,),
              FlatButton(
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Text("Add Photo",style: TextStyle(color: Theme.of(context).primaryColor),),
                onPressed: () {
                  print("refunding action");
                },
              ),
              SizedBox(height: 8,),
              FlatButton(
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Text("Submit Refund",style: TextStyle(color: Theme.of(context).primaryColor),),
                onPressed: () {
                  print("refunding action");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
