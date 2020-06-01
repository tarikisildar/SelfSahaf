import 'package:flutter/material.dart';
class OrderSummary extends StatefulWidget{
  @override
  _OrderSummaryState createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary>{
  @override
  Widget build(BuildContext widget){
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
                print("PARA CEKME ISLEMI");
              },
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 15,
                    child: Text(
                      "Place Order",
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