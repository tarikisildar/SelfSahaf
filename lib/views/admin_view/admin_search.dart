import 'package:flutter/material.dart';
import 'package:selfsahaf/views/admin_view/admin_main_page.dart';
import 'package:selfsahaf/views/customer_view/products_pages/product_card.dart';

class AdminSearch extends StatefulWidget {
  @override
  _AdminSearchState createState() => new _AdminSearchState();
}

class _AdminSearchState extends State<AdminSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GestureDetector(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Container(
            width: MediaQuery.of(context).size.width - 220,
            height: 60,
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  side: BorderSide(color: Color.fromRGBO(230, 81, 0, 1))),
              color: Colors.white,
              onPressed: () async {
                //@TODO : degistir bunu
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminMainPage()),
                );
              },
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 15,
                    child: Text(
                      "Summary",
                      style: TextStyle(
                          color: Color.fromRGBO(230, 81, 0, 1), fontSize: 20),
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
