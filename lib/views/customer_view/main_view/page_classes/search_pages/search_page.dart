import 'dart:typed_data';

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
  TextEditingController queryController;

  // _SearchPageState(){
  //   queryController.addListener(() {
  //     if(queryController.text.length>=3){
  //       print("ARKAYA SEARCH ISTEGI");
  //     }
  //     else {
  //       print(3-queryController.text.length);
  //     }

  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          floatingActionButton: FilterFloating(),
          appBar: AppBar(
            leading: InkWell(
              child: Icon(Icons.search),
              onTap: () {
                print(queryController.text);
              },
            ),
            backgroundColor: Color(0xffe65100),
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Text(
                    "Books",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Tab(
                  child: Text(
                    "Categories",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Tab(
                  child: Text(
                    "ISBN",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            title: Container(
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                controller: queryController,
                decoration: InputDecoration(
                    hintText: "Type to Search",
                    hintStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none),
              ),
            ),
          ),
          body: TabBarView(
            children: [
              Container(
                color: Color(0xffe65100),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    children: <Widget>[
                      Text("BOOK CEK"),
                    ],
                  ),
                ),
              ),
              Container(
                color: Color(0xffe65100),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    children: <Widget>[
                      Text("KATEGORI CEK"),
                    ],
                  ),
                ),
              ),
              Container(
                color: Color(0xffe65100),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    children: <Widget>[
                      Text("ISBN CEK"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FilterFloating extends StatefulWidget {
  @override
  _FilterFloatingState createState() => _FilterFloatingState();
}

class _FilterFloatingState extends State<FilterFloating> {
  bool _show = true;
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
                        )
                      ],
                    ),
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: ListView(
                        children: <Widget>[
                          Expanded(
                              flex: 3,
                              child: Row(
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
                              )),
                          Center(
                            child: Row(
                              children: <Widget>[
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

  void _showButton(bool value) {
    setState(() {
      _show = value;
    });
  }
}
