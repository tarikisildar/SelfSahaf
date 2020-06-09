import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:Selfsahaf/controller/user_controller.dart';
import 'package:Selfsahaf/views/customer_view/profile_pages/addAddress.dart';

class AddressWidget extends StatelessWidget {
  String addressName, addressLine, city, country, postalCode;
  AuthService userService = GetIt.I<AuthService>();
  AddressWidget(
      {this.addressName,
      this.addressLine,
      this.city,
      this.country,
      this.postalCode,
      this.addressID});
  int addressID;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 4.0, bottom: 4.0, left: 10, right: 10),
      child: Container(
        padding: EdgeInsets.all(5),
        height: 120,
        margin: EdgeInsets.all(5),
        decoration:
            BoxDecoration(color: Colors.white, shape: BoxShape.rectangle, borderRadius: BorderRadius.all(Radius.circular(25))),
        child: Row(
          children: <Widget>[
            Expanded(
                flex: 7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(5),
                    alignment: Alignment.centerLeft,
                    child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.all(2),
                        child: Text(
                          " $addressName: ${addressLine} ",
                          overflow: TextOverflow.clip,
                          maxLines: 3,
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        )),
                  ),
                  Container(
                    padding: EdgeInsets.all(2),
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "$city/$country",
                      maxLines: 1,
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.right,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(2),
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "$postalCode",
                      maxLines: 1,
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.right,
                    ),
                  ),
                ])),
            Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                   InkWell(
                      onTap: () => showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              content: AddAddress(
                                addType: 2,
                                addressID: addressID,
                                addressLine: addressLine,
                                addressName: addressName,
                                city: city,
                                country: country,
                                postalCode: postalCode,
                              ),
                              title: Text("Update Address Information"),
                            ),
                          ),
                      child: Icon(
                        Icons.edit,
                        size: 40,
                        color: Theme.of(context).primaryColor,
                      )),
                  InkWell(
                      onTap: () => showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              content:
                                  Text("Do you want to delete $addressName"),
                              title: Text("Are you sure"),
                              actions: <Widget>[
                                FlatButton(
                                    onPressed: () {
                                      userService
                                          .deleteAddress(addressID)
                                          .then((value) {
                                        if (value == 200) {
                                          Navigator.pop(context);
                                          return null;
                                        } else
                                          print("HATATATAT");
                                      });
                                    },
                                    child: Text("yes")),
                                FlatButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text("no")),
                              ],
                            ),
                          ).then((value){
                            
                          }),
                      child: Icon(
                        Icons.delete,
                        size: 40,
                        color: Theme.of(context).primaryColor,
                      ))
                ]))
          ],
        ),
      ),
    );
  }
}
