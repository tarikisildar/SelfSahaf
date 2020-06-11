import 'package:Selfsahaf/views/customer_view/shopping_cart/card_information.dart';
import 'package:flutter/material.dart';

class ShippingCompanyList extends StatefulWidget{
  @override 
  _ShippingCompanyListState createState() => _ShippingCompanyListState();
}

class _ShippingCompanyListState extends State<ShippingCompanyList>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      floatingActionButton: 
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Container(
                width: MediaQuery.of(context).size.width - 32,
                height: 60,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(color: Color.fromRGBO(230, 81, 0, 1))),
                  color: Colors.white,
                  onPressed: () async {
                    Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CardInformation()),
                );
                  },
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 15,
                        child: Text(
                          "Card Information",
                          style: TextStyle(
                              color: Color.fromRGBO(230, 81, 0, 1),
                              fontSize: 20),
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
child: Padding(
  padding: const EdgeInsets.all(16.0),
  child: ListView(
    children: <Widget>[
      Text("AAASSS"),
      Text("AAASSS"),
      Text("AAASSS"),
      Text("AAASSS"),
      Text("AAASSS"),
      Text("AAASSS"),
      Text("AAASSS"),
      Text("AAASSS"),
      Text("AAASSS"),
      Text("AAASSS"),
    ],
  ),
),

      ),
    );
  }
}