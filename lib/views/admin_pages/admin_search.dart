import 'package:flutter/material.dart';

class AdminSearch extends StatefulWidget {
  @override
  _AdminSearchState createState() => new _AdminSearchState();
}

class _AdminSearchState extends State<AdminSearch> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
              child: Icon(Icons.arrow_back),
              onTap: () => Navigator.pop(context),
            ),

          ),
          body: TabBarView(
            children: [
              Icon(Icons.book, color: Color(0xffe65100),),
              Icon(Icons.person, color: Color(0xffe65100)),
            ],
          ),
        ),
      ),
    );
  }
}
