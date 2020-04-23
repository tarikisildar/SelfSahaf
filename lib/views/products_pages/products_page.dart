import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:selfsahaf/views/products_pages/add_book.dart';
import 'package:selfsahaf/views/products_pages/product_card.dart';
import 'package:selfsahaf/controller/product_services.dart';
import "package:selfsahaf/models/book.dart";

class ProductsPage extends StatefulWidget {
  ProductsPage({Key key}) : super(key: key);

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  ProductService get _productService => GetIt.I<ProductService>();
  List<Book> bookList = [null];
  final TextEditingController _filter = new TextEditingController();
  bool _isloading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
  }

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
          IconButton(
              icon: Icon(Icons.add_box),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddBook()));
              }),
        ],
      ),
      body: Container(
          color: Color(0xffe65100),
          padding: const EdgeInsets.all(16.0),
          child: RefreshIndicator(
            onRefresh: () {
              return _productService.getSelfBooks().then((e) {
                setState(() {
                  _isloading = false;
                  this.bookList = e;
                });
              });
            },
            key: _refreshIndicatorKey,
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                if (_isloading) {
                  return CircularProgressIndicator();
                }
                if (bookList[0] == null) {
                  return Center(child: Text("No Books"));
                } else {
                  return Dismissible(
                    key: ValueKey(bookList[index].productID),
                    child: ProductCard(
                      bookName: bookList[index].name,
                      authorName: bookList[index].authorName,
                      publisherName: bookList[index].publisher,
                      price: "${bookList[index].price}",
                    ),
                    direction: DismissDirection.horizontal,
                    onDismissed: (direction) {
                      print("sa");
                    },
                    confirmDismiss: (direction) async {
                      if (direction == DismissDirection.startToEnd) {
                        print("soldan sağa");
                      } else if (direction == DismissDirection.endToStart) {
                        print("sağdan dola");
                      }
                      final result = await showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              content: Text("sa"),
                            );
                          });
                      print(result);
                      return result;
                    },
                    //sağdan sola
                    secondaryBackground: Container(
                     
                        padding: EdgeInsets.all(12),
                        margin: EdgeInsets.all(8),
                        child: Align(
                            child: Icon(Icons.edit,
                                color:Colors.white, size:50),
                            alignment: Alignment.centerRight),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(20.0),
                        )),
                    //soldan sağa
                    background: Container(
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.only(left: 16),
                      child: Align(
                        child: Icon(Icons.delete,
                            color: Colors.white, size: 50,),
                        alignment: Alignment.centerLeft,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  );
                }
              },
              itemCount: (bookList[0] == null) ? 1 : bookList.length,
            ),
          ))

      /*RefreshIndicator(
        onRefresh: () {
          return _productService.getSelfBooks().then((e) {
            setState(() {
              this.bookList = e;
            });
          });
        },
        key: _refreshIndicatorKey,
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            
            if (bookList[0] == null) {
              return Center(child: Text("No Books"));
            } else {
              return ProductCard(
                bookName: bookList[index].name,
                authorName: bookList[index].authorName,
                publisherName: bookList[index].publisher,
                price: "${bookList[index].price}",
              );
            }
          },
          itemCount: (bookList[0] == null) ? 1 : bookList.length,

        ),
      )*/
      /* (_isloading)
          ? CircularProgressIndicator()
          : Container(
              color: Color(0xffe65100),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: (bookList[0]==null)
                    ? Center(
                        child: listvie
                      )
                    : ListView.builder(
                      
                        itemCount: bookList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ProductCard(
                            bookName: bookList[index].name,
                            authorName: bookList[index].authorName,
                            publisherName: bookList[index].publisher,
                            price: "${bookList[index].price}",
                          );
                        },
                      ),
              ),
            )*/
      ,
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
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(20),
                          topRight: const Radius.circular(20))),
                  child: Container(
                    height: 450,
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: FlatButton(
                              onPressed: () {},
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                              color: Colors.black,
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
