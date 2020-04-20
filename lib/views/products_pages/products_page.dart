import 'package:flutter/material.dart';
import 'package:selfsahaf/views/products_pages/add_book.dart';
import 'package:selfsahaf/views/products_pages/product_card.dart';

class ProductsPage extends StatefulWidget {
  ProductsPage({Key key}) : super(key: key);

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final TextEditingController _filter = new TextEditingController();
  List names = new List();
  List books = new List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 13,
        leading: InkWell(
          child: Icon(Icons.arrow_back),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: Padding(
          padding: const EdgeInsets.all(3.0),
          child: TextField(
            style: TextStyle(
              color: Colors.black,
            ),
            controller: _filter,
            decoration: new InputDecoration(
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
                    child: new Icon(
                  Icons.search,
                  color: Colors.white,
                )),
                hintText: 'Ara...',
                hintStyle: TextStyle(
                  color: Colors.white,
                )),
          ),
          
        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add_box), onPressed: () {
            Navigator.push(context,MaterialPageRoute(builder:(context)=> AddBook()));
          }),
        ],

      ),
      body: Container(
        color: Color(0xffe65100),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              ProductCard(bookName: "Binbir Turlu Aglama Sekilleri",authorName: "Ali Osman Kocaman",publisherName: "AOK Yayinlari",price: "60",),
              ProductCard(bookName: "Binbir Turlu Aglama Sekilleri",authorName: "Ali Osman Kocaman",publisherName: "AOK Yayinlari",price: "60",),
            ],
          ),
        ),
      ),
      floatingActionButton: FilterFloating(),
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
                  height: 450, 
                  color: Colors.white,
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
