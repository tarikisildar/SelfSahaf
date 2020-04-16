
import 'package:flutter/material.dart';
class ProductsDialog extends StatefulWidget {
  ProductsDialog({Key key}) : super(key: key);

  @override
  _ProductsDialogState createState() => _ProductsDialogState();
}

class _ProductsDialogState extends State<ProductsDialog> {
  TextEditingController _addressController = TextEditingController();
  bool _productsShowDialog = true;
  var _countries = ['Country', 'Turkey', 'England'];
  var _cities = {
    'Country': ['City', 'sas'],
    'Turkey': ['Ankara', 'İstanbul', 'Yozgat'],
    'England': ['Tahsim', 'London']
  };

  var _currentCountry = 'Country';
  

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return (_productsShowDialog)
              ? Container(
                  width: 250,
                  height: 150,
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Do you want to be a seller?",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 25),
                      ),
                      Container(
                          padding: EdgeInsets.fromLTRB(20, 30, 10, 5),
                          child: Row(
                            children: <Widget>[
                              InkWell(
                                child: Container(
                                  color: Theme.of(context).primaryColor,
                                  padding: EdgeInsets.all(5.0),
                                  margin: EdgeInsets.all(5.0),
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 30),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                              InkWell(
                                child: Container(
                                  padding: EdgeInsets.all(5.0),
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
                              )
                            ],
                          ))
                    ],
                  ),
                )
              : Container(
                  width: 250,
                  height: 250,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 200,
                        child: TextFormField(
                          controller: _addressController,
                          maxLines: 4,
                          decoration: InputDecoration(
                            hintText: "Address",
                            contentPadding: EdgeInsets.all(5.0),
                          ),
                        ),
                      ),
                      Container(
                        child: DropdownButton(
                          
                          items: _countries.map((String dropDownItem) {
                            return DropdownMenuItem<String>(
                              value: dropDownItem,
                              child: Text(dropDownItem),
                            );
                          }).toList(),
                          onChanged: (String country) {
                            setState(() {
                              this._currentCountry = country;
                    
                            });
                          },
                          value: this._currentCountry,
                        ),
                      ),
                      Container(
                        child: DropdownButton(
                          
                          items:null,

                          onChanged: null
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            InkWell(
                              child: Icon(
                                Icons.close,
                                color: Theme.of(context).primaryColor,
                                size: 40,
                              ),
                            ),
                            InkWell(
                              child: Icon(
                                Icons.check,
                                color: Theme.of(context).primaryColor,
                                size: 50,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
