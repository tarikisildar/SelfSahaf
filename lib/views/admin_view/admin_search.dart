import 'package:flutter/material.dart';
import 'package:Selfsahaf/views/admin_view/admin_main_page.dart';
import 'package:Selfsahaf/views/customer_view/products_pages/product_card.dart';

class AdminSearch extends StatefulWidget {
  @override
  _AdminSearchState createState() => new _AdminSearchState();
}

class _AdminSearchState extends State<AdminSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FilterFloating(),
      body: MaterialApp(
        home: DefaultTabController(
          
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              
              backgroundColor: Color(0xffe65100),
              bottom: TabBar(
                indicatorColor: Colors.white,
                tabs: [
                  Tab(
                    text: "Book",
                  ),
                  Tab(text: "User"),
                ],
              ),
              title: TextField(
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    prefixIcon: InkWell(
                        child: Icon(
                      Icons.search,
                      color: Colors.white,
                    )),
                    hintText: 'Ara...',
                    hintStyle: TextStyle(
                      color: Colors.white,
                    )),
              ),
              leading: GestureDetector(
                child: Icon(Icons.arrow_back_ios),
                onTap: () => Navigator.pop(context),
              ),

            ),
            body: TabBarView(
              children: [
                Container(
                  color: Color(0xffe65100),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0,left:16.0,top:8,bottom:8),
                    child: ListView(
                      children: <Widget>[
                        ProductCard(
                          authorName: "Piotr Zielinski the twentieth",
                          bookName: "alios",
                          price: "20",
                          publisherName: "alios publishing",
                          productID: 5,
                  sellerID: 2,
                        ),
                      ],
                    ),
                  ),
                ),
                Icon(Icons.person, color: Color(0xffe65100)),
              ],
            ),
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
                                        style: TextStyle(color: Colors.white,fontSize: 24),
                                      )),
                                  Expanded(
                                    flex: 1,
                                    child: InkWell(
                                      onTap: () => Navigator.of(context).pop(),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,),
                                        
                                        child: Icon(Icons.close,color: Color(0xffe65100),
                                      ),
                                    ),
                                  ),),
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
