import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:Selfsahaf/controller/product_services.dart';
import "package:Selfsahaf/models/book.dart";
import 'package:Selfsahaf/views/customer_view/products_pages/add_book.dart';
import 'package:Selfsahaf/views/customer_view/products_pages/book_profile.dart';
import 'package:Selfsahaf/views/customer_view/products_pages/product_card.dart';

class ProductsPage extends StatefulWidget {
  ProductsPage({Key key}) : super(key: key);

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  ProductService get _productService => GetIt.I<ProductService>();
  final TextEditingController _filter = new TextEditingController();
  List<Book> bookList = [null];
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
                hintText: 'Search...',
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
                    if (e != null) bookList.add(e);
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
                  return Padding(
                    padding: const EdgeInsets.all(35.0),
                    child: Center(child: Text("No Books on Sale", style: TextStyle(color: Colors.white, fontSize: 25),)),
                  );
                } else {
                  return Dismissible(
                    key: ValueKey(bookList[index].productID),
                    child: ProductCard(
                      bookName: bookList[index].name,
                      authorName: bookList[index].authorName,
                      publisherName: bookList[index].publisher,
                      price: "${bookList[index].price}",
                      productID: bookList[index].productID,
                      sellerID: bookList[index].sellerID,
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
                                        selectedBook: bookList[index],isproduct: true,)))
                            .then((onValue) {
                          print(onValue);
                          setState(() {
                            if (onValue != null) {
                              bookList.removeAt(index);
                              bookList.add(onValue);
                            }
                          });

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
                                  "Confirm if you want to delete ${bookList[index].name}"),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
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
