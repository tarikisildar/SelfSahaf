import 'dart:typed_data';

import 'package:Selfsahaf/controller/product_services.dart';
import 'package:Selfsahaf/controller/search_service.dart';
import 'package:Selfsahaf/views/customer_view/products_pages/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:Selfsahaf/controller/book_controller.dart';
import 'package:Selfsahaf/views/registration/input_field.dart';

class SearchPage extends StatefulWidget {
  // ExamplePage({ Key key }) : super(key: key);
  @override
  _SearchPageState createState() => new _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
    SearchService get searchService => GetIt.I<SearchService>();
  TextEditingController _minNumber = TextEditingController();
  TextEditingController _maxNumber = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  final _numberFormKey = GlobalKey<FormState>();

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  String _numberValidation(String value) {
    if (isNumeric(value)) {
      if (double.parse(value) < 0 || double.parse(value) >= 999999999)
        return "invalid";
      else {
        return null;
      }
    } else
      return "invalid";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Container(
              alignment: Alignment.center,
              height: 50,
              child: Image.asset("images/logo_white/logo_white.png")),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              Center(
                child: Text(
                  "Search",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
              Center(
                child: Row(
                  children: <Widget>[
                    Expanded(
                        flex: 3,
                        child: Text(
                          "By Name",
                          style: TextStyle(color: Colors.white),
                        )),
                    Expanded(
                      flex: 8,
                      child: Row(
                  
                        children: <Widget>[
                          Expanded(
                        flex: 8,
                        child: InputField(
                          lines: 1,
                          controller: _nameController,
                          inputType: TextInputType.text,
                          validation: null,
                          labelText: "Name",
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        flex: 2,
                        child: FlatButton(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Icon(Icons.search),
                          onPressed: () {
                            searchService.searchBooksByName(_nameController.text, 0, 8);
                            print("BURA DAHA BITMEDI BITER INS");
                          },
                        ),
                      ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 50,
                thickness: 2,
                color: Colors.white,
              ),
               Center(
                child: Row(
                  children: <Widget>[
                    Expanded(
                        flex: 3,
                        child: Text(
                          "By Name",
                          style: TextStyle(color: Colors.white),
                        )),
                    Expanded(
                      flex: 8,
                      child: Row(
                  
                        children: <Widget>[
                          Expanded(
                        flex: 8,
                        child: InputField(
                          lines: 1,
                          controller: _maxNumber,
                          inputType: TextInputType.text,
                          validation: _numberValidation,
                          labelText: "Name",
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        flex: 2,
                        child: FlatButton(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Icon(Icons.search),
                          onPressed: () {
                            
                            print("BURA DAHA BITMEDI BITER INS");
                          },
                        ),
                      ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 50,
                thickness: 2,
                color: Colors.white,
              ),
              Center(
                child: Form(
                  key: _numberFormKey,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          flex: 3,
                          child: Text(
                            "By Price",
                            style: TextStyle(color: Colors.white),
                          )),
                          SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        flex: 4,
                        child: InputField(
                          lines: 1,
                          controller: _minNumber,
                          inputType: TextInputType.number,
                          validation: _numberValidation,
                          labelText: "Min",
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 4,
                        child: InputField(
                          lines: 1,
                          controller: _maxNumber,
                          inputType: TextInputType.number,
                          validation: _numberValidation,
                          labelText: "Max",
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        flex: 2,
                        child: FlatButton(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Icon(Icons.search),
                          onPressed: () {
                            if(_numberFormKey.currentState.validate())
                            print("BURA DAHA BITMEDI BITER INS");
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
               Divider(
                height: 50,
                thickness: 2,
                color: Colors.white,
              ),
              Center(
                child: Row(
                  children: <Widget>[
                    Expanded(
                        flex: 3,
                        child: Text(
                          "By Language",
                          style: TextStyle(color: Colors.white),
                        )),
                    Expanded(
                      flex: 8,
                      child: Row(
                  
                        children: <Widget>[
                          Expanded(
                        flex: 8,
                        child: InputField(
                          lines: 1,
                          controller: _maxNumber,
                          inputType: TextInputType.text,
                          validation: _numberValidation,
                          labelText: "Name",
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        flex: 2,
                        child: FlatButton(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Icon(Icons.search),
                          onPressed: () {
                            
                            print("BURA DAHA BITMEDI BITER INS");
                          },
                        ),
                      ),
                        ],
                      ),
                    ),
                    
                  ],
                ),
              ),
               Divider(
                height: 50,
                thickness: 2,
                color: Colors.white,
              ),
              Center(
                child: Row(
                  children: <Widget>[
                    Expanded(
                        flex: 3,
                        child: Text(
                          "By Category",
                          style: TextStyle(color: Colors.white),
                        )),
                    Expanded(
                      flex: 8,
                      child: Row(
                  
                        children: <Widget>[
                          Expanded(
                        flex: 8,
                        child: InputField(
                          lines: 1,
                          controller: _maxNumber,
                          inputType: TextInputType.text,
                          validation: _numberValidation,
                          labelText: "Name",
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        flex: 2,
                        child: FlatButton(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Icon(Icons.search),
                          onPressed: () {
                            
                            print("BURA DAHA BITMEDI BITER INS");
                          },
                        ),
                      ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class FilterFloating extends StatefulWidget {
  @override
  _FilterFloatingState createState() => _FilterFloatingState();
}

class _FilterFloatingState extends State<FilterFloating> {
  bool _show = true;
  int typeGroup;
  @override
  Widget build(BuildContext context) {
    return _show
        ? FloatingActionButton(
            backgroundColor: Colors.white,
            child: Icon(
              Icons.lightbulb_outline,
              color: Color(0xffe65100),
            ),
            onPressed: () {
              var sheetController = showBottomSheet(
                context: context,
                builder: (context) => Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(20),
                          topRight: const Radius.circular(20))),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xffe65100),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.8),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: ListView(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                  flex: 10,
                                  child: Text(
                                    "Filtrele",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 24),
                                  )),
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () => Navigator.of(context).pop(),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: Icon(
                                      Icons.close,
                                      color: Color(0xffe65100),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Center(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 2,
                                  child: Radio(
                                      activeColor: Colors.white,
                                      value: 0,
                                      groupValue: typeGroup,
                                      onChanged: (T) {
                                        _changeRadio(T);
                                      }),
                                ),
                                Expanded(
                                    flex: 5,
                                    child: Text(
                                      "By Price",
                                      style: TextStyle(color: Colors.white),
                                    )),
                                Expanded(
                                  flex: 5,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      FlatButton(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                        child: Text(
                                          "Increasing",
                                          style: TextStyle(
                                              color: Color(0xffe65100)),
                                        ),
                                        onPressed: () {
                                          print("BURA DAHA BITMEDI BITER INS");
                                        },
                                      ),
                                      FlatButton(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                        child: Text(
                                          "Decreasing",
                                          style: TextStyle(
                                              color: Color(0xffe65100)),
                                        ),
                                        onPressed: () {
                                          print("BURA DAHA BITMEDI BITER INS");
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 2,
                            color: Colors.white,
                          ),
                          Center(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                    flex: 5,
                                    child: Text(
                                      "By Alphabet",
                                      style: TextStyle(color: Colors.white),
                                    )),
                                Expanded(
                                  flex: 5,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      FlatButton(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                        child: Text(
                                          "A-Z",
                                          style: TextStyle(
                                              color: Color(0xffe65100)),
                                        ),
                                        onPressed: () {
                                          print("BURA DAHA BITMEDI BITER INS");
                                        },
                                      ),
                                      FlatButton(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                        child: Text(
                                          "Z-A",
                                          style: TextStyle(
                                              color: Color(0xffe65100)),
                                        ),
                                        onPressed: () {
                                          print("BURA DAHA BITMEDI BITER INS");
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
              _showButton(false);
              sheetController.closed.then((value) {
                _showButton(true);
              });
            },
          )
        : Container();
  }

  void _changeRadio(int T) {
    setState(() {
      typeGroup = T;
    });
  }

  void _showButton(bool value) {
    setState(() {
      _show = value;
    });
  }
}
