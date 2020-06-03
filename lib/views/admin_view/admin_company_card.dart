import 'package:flutter/material.dart';

class ShippingCompaniesCardAdmin extends StatefulWidget {
  final String companyName;
  final String price;
  bool isSelected = false;
  ShippingCompaniesCardAdmin({
    @required this.companyName,
    @required this.price,
  });
  @override
  _ShippingCompaniesCardAdminState createState() => _ShippingCompaniesCardAdminState();
}

class _ShippingCompaniesCardAdminState extends State<ShippingCompaniesCardAdmin> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top:8.0,bottom: 8.0,right: 16.0,left: 16.0),
          child: Container(
            height: 70,
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 10,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                       Text(
                          "${widget.companyName}",
                          style: TextStyle(color: Colors.white,fontSize: 20),
                        ),
                        SizedBox(height: 8,),
                        Text(
                          "${widget.price} TL",
                          style: TextStyle(color: Colors.white),
                        ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 35,
                    ),
                    onTap: () {
                      print("Editlemek istiyorum");
                    },
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 35,
                    ),
                    onTap: () {
                      print("Editlemek istiyorum");
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Divider(
          thickness: 2,
          color: Colors.white,
        ),
      ],
    );
  }
}
