import 'package:flutter/material.dart';
import 'package:selfsahaf/page_classes/sahaf_drawer.dart';

class MainPage extends StatefulWidget{
  
  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
  var _categories = ["kitap","kitap1","kitap2","kitap3"];
  Widget _buildList() {
    return ListView.builder(
      itemCount: _categories == null ? 0 : _categories.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          
          children: <Widget>[
            Container(
              child: new ListTile(
                leading: GestureDetector(
                  child: Icon(
                    Icons.rate_review,
                    color: Color.fromRGBO(58, 153, 137,1),
                  ),
                  onTap: () => {}
                          
                ),
                title: Text(_categories[index]),
                onTap: () => print(_categories[index]),
              ),
            ),
            Divider(
              thickness: 1.0,
              color: Colors.black38,
            )
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("sasasasa"),
      ),
      drawer: Drawer(
        elevation: 5.0,

        child: Container(
          color: Color.fromRGBO(255, 165, 0, 1),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(22.0,55.0,22.0,20),
            child: Column(
              children: <Widget>[
                Container(
                  child: Image.asset(
                    "images/logo_white/logo_white.png"
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:20.0),
                  child: Container(
                    child: Text(
                      "Ali Osman Kocaman" , style: TextStyle(color: Colors.white),
                    ),
                  ),

                ),
                
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child:Column(
          children: <Widget>[
            Text(
              "sa"
            ),
          ],
        )
      ),
    );
  }

}