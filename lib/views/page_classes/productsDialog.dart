import 'package:flutter/material.dart';
import 'package:selfsahaf/views/products_pages/products_page.dart';
import 'package:selfsahaf/controller/product_services.dart';

class ProductsDialog extends StatefulWidget {
  ProductsDialog({Key key}) : super(key: key);

  @override
  _ProductsDialogState createState() => _ProductsDialogState();
}

class _ProductsDialogState extends State<ProductsDialog> {

  TextEditingController _addresline = TextEditingController();
  TextEditingController _postalcode=TextEditingController();
  bool _productsShowDialog = true;
  var _countryDrop = ['Turkey', 'England'];
  var currentSelected = null;
  var _cityDrop = [];

  void loadCities(input){
    
    if(input == 1){
      for (var i = 0; i < _cities['Turkey'].length; i++) {
        _cityDrop.add(DropdownMenuItem(child: Text(_cities['Turkey'][i]),value: i));
      }
    }
    else{
      for (var i = 0; i < _cities['England'].length; i++) {
        _cityDrop.add(DropdownMenuItem(child: Text(_cities['England'][i]),value: i));
      }
      
    }
  }
  var _countries = ['Country', 'Turkey', 'England'];
  var _cities = {
    'Country': ['City'],
    'Turkey': ['Ankara', 'İstanbul', 'Yozgat'],
    'England': ['Manchester', 'London']
  };

  var _country = 'Country';
  var _city = 'City';
  List<String> _citySelection=['City'];
  
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
              : SingleChildScrollView(
                
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 200,
                        child: TextFormField(
                          controller: _addresline,
                          maxLines: 3,
                          decoration: InputDecoration(
                            labelText: 'Address',
                            hintText: "write full address",
                            contentPadding: EdgeInsets.all(5.0),
                          ),
                          autofocus: false,
                        
                        ),
                      ),
                      Container(
                        child: DropdownButton<String>(
                          
                          hint: Text("Country"),
                          items: _countryDrop.map((String dropdownStringItem){
                            return DropdownMenuItem<String>(
                              value: dropdownStringItem,
                              child: Text(dropdownStringItem),
                            );
                          }).toList(),
                          onChanged: (String newValueSelected) {
                            setState(() {
                              this.currentSelected = newValueSelected;
                              // loadCities(value);
                            });
                          },
                          value: currentSelected,
                          
                        ),
                      ),
                      Container(
                          child: DropdownButton(
                                  items:
                                      _citySelection.map((String dropDownItem) {
                                    return DropdownMenuItem<String>(
                                      value: dropDownItem,
                                      child: Text(dropDownItem),
                                    );
                                  }).toList(),
                                  onChanged: (String city) {
                                    setState(() {
                                      this._city=city;
                                    });
                                  },
                                  value: this._city,
                                )
                              ),
                              Container(
                     
                        child: TextFormField(
                            controller: _postalcode,
                             decoration: InputDecoration(
                            hintText: "Ex: 06123",
                            contentPadding: EdgeInsets.all(5.0),
                            labelText: 'Postal Code'
                          ),
                          autofocus: false,
                      
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0,15,10,0),
           
                        alignment: Alignment.bottomRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            InkWell(
                              
                              child: Icon(
                                Icons.close,
                                color: Theme.of(context).primaryColor,
                                size: 30,
                              ),
                              onTap: ()=>Navigator.pop(context),
                            ),
                            InkWell(
                              child: Icon(
                                Icons.check,
                                color: Theme.of(context).primaryColor,
                                size: 30,
                              ),
                              onTap: (){
                                if(_postalcode.text!=''&&_addresline.text!=''&&_city!='City'&&_country!='Country')
                                   Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductsPage()));
                              },
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
