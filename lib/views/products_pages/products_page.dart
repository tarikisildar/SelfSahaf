import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:selfsahaf/views/products_pages/add_book.dart';
import 'package:selfsahaf/views/products_pages/product_card.dart';
import 'package:selfsahaf/controller/product_services.dart';
import "package:selfsahaf/models/book.dart";
import 'package:selfsahaf/views/products_pages/book_profile.dart';

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

  Future<Null> _refresh() {
    return _productService.getSelfBooks().then((e) {
      setState(() {
        _isloading = false;
        this.bookList = e;
      });
    });
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
                setState(() {
                  _isloading = false;
                });
         
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddBook(),
                            maintainState: true))
                    .then((e) {
                  setState(() {
                    bookList.add(e);
                    WidgetsBinding.instance.addPostFrameCallback(
                        (_) => _refreshIndicatorKey.currentState.show());
                  });
                });
              }),
        ],
      ),
      body: Container(
          color: Color(0xffe65100),
          padding: const EdgeInsets.all(16.0),
          child: RefreshIndicator(
            onRefresh: () => _refresh(),
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
                      //right to left for information
                      if (direction == DismissDirection.endToStart) {
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BookProfile(
                                        selectedBook: bookList[index])))
                            .then((onValue) {
                          WidgetsBinding.instance.addPostFrameCallback(
                              (_) => _refreshIndicatorKey.currentState.show());
                        });

                        return false;
                      }
                      //left to right for delete
                      final result = await showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              content: Text(
                                  "Confirm if you want to delete  ${bookList[index].name}"),
                              title: Text("Do yo want to delete the book?"),
                              actions: <Widget>[
                                FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      side: BorderSide(
                                          color:
                                              Color.fromRGBO(230, 81, 0, 1))),
                                  child: Text(
                                    "DELETE",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  color: Theme.of(context).primaryColor,
                                  onPressed: () {
                                    _productService
                                        .deleteBook(bookList[index].productID)
                                        .then((e) {
                                      if (e) {
                                        print("deleted");
                                        setState(() {
                                            bookList.removeAt(index);
                                        });
                                      
                                        if (bookList.length == 0) {
                                          setState(() {
                                            bookList = [null];
                                          });
                                        }

                                        Navigator.of(context).pop(true);
                                      } else
                                        Navigator.of(context).pop(false);
                                    });
                                  },
                                ),
                                FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      side: BorderSide(
                                          color:
                                              Color.fromRGBO(230, 81, 0, 1))),
                                  child: Text(
                                    "CANCEL",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  color: Theme.of(context).primaryColor,
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                ),
                              ],
                            );
                          });
                      if (result == null) return false;
                      print(result);
                      return result;
                    },
                    //sağdan sola
                    secondaryBackground: Container(
                        padding: EdgeInsets.all(12),
                        margin: EdgeInsets.all(8),
                        child: Align(
                            child:
                                Icon(Icons.edit, color: Colors.white, size: 50),
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
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 50,
                        ),
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
