import 'package:flutter/material.dart';
import 'package:Selfsahaf/views/admin_view/admin_company_card.dart';
import 'package:Selfsahaf/views/customer_view/category_view/category_card.dart';
import 'package:Selfsahaf/views/customer_view/shipping_view/shipping_card.dart';

class ShippingCompanies extends StatefulWidget{
  @override
  _ShippingCompaniesState createState() => _ShippingCompaniesState();
}

class _ShippingCompaniesState extends State<ShippingCompanies>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
          title: Container(
            height: 22,
            child: Image.asset("images/selfadmin_logo/selfadmin.png"),
          ),
          leading: InkWell(
            child: Icon(Icons.arrow_back_ios,color: Colors.white,),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Text("Edit Companies",style: TextStyle(fontSize: 24,color: Colors.white),),
                  
                ),
              ),
              Divider(thickness: 2, color: Colors.white,),
              SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      ShippingCompaniesCardAdmin(
                        companyName: "Aras",
                        price: "10",
                      ),
                    ],
                  ),
                
              ),
            ],
          ),
        ),
    );
  }
}
