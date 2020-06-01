import 'package:flutter/material.dart';
import 'package:selfsahaf/views/customer_view/shopping_cart/card_information.dart';

class OrderAddress extends StatefulWidget {
  @override
  _OrderAddressState createState() => _OrderAddressState();
}

class _OrderAddressState extends State<OrderAddress> {
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
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
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
                    print("floating accept button");
                  },
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 15,
                        child: Text(
                          "Add New Address",
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
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 50.0),
        child: Container(
          child: Center(
            child: ListView(
              children: <Widget>[
                Center(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                  child: Text(
                    "Saved Addresses",
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                )),
                Divider(
                  color: Colors.white,
                  thickness: 3,
                ),
                AddressElement(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AddressElement extends StatefulWidget {
  // AddressElement(){
  //   @required int addressIndex;
  //   @required String address1;
  //   String address2;
  //   bool selected = false;
  // }
  _AddressElementState createState() => _AddressElementState();
}

class _AddressElementState extends State<AddressElement>{
  bool selected = false;
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      color: Colors.transparent,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Checkbox(
                        activeColor: Colors.white,
                        checkColor: Colors.white,
                        onChanged: (bool value) {
                          setState(() => this.selected = value);
                        },
                        value: selected,),
                  ),
                ),
                Expanded(
                  flex: 18,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Address 1",style: TextStyle(color: Colors.white,fontSize: 16),),
                      Text("EV",style: TextStyle(color: Colors.white,fontSize: 20),),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 2.5,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
