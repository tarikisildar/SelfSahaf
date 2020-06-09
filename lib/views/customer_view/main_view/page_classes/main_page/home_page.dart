import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:Selfsahaf/controller/book_controller.dart';
import 'package:Selfsahaf/controller/product_services.dart';
import 'package:Selfsahaf/controller/user_controller.dart';
import 'package:Selfsahaf/models/book.dart';
import 'package:Selfsahaf/views/customer_view/main_view/page_classes/main_page/book_card.dart';
import 'package:Selfsahaf/views/customer_view/main_view/page_classes/main_page/home_page_carousel.dart';
import 'package:Selfsahaf/views/customer_view/main_view/page_classes/main_page/sahaf_drawer.dart';
import 'package:Selfsahaf/views/customer_view/shopping_cart/shopping_cart.dart';



  class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}
class _HomePageState extends State<HomePage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  ScrollController _scrollController = new ScrollController();
  List<Book> bookList = [null];
  bool _isloading = true;
  int _index = 0;
  int page = 0, size = 4, localpage = 0;
  bool checkPage;
  List<Widget> _pages;
  AuthService get userService => GetIt.I<AuthService>();
  BookService get _bookService => GetIt.I<BookService>();

  bool _loading = true;

  
  @override
  void initState() {
    _fetchData();

    
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
    
  }

  _getMoreData() async {
    setState(() {
      _isloading = true;
    });

    print("page: $page");
    List<Book> newbooks;
    newbooks = await _bookService.getBooks(page, size);
    setState(() {
      if (newbooks.length == 0) {
        _isloading = false;
        return;
      } else if (bookList.length % size != 0 || newbooks.length != size) {
        for (int i = (bookList.length % 4); i < newbooks.length; i++) {
          bookList.add(newbooks[i]);
        }
        if (newbooks.length == size) page += 1;
      } else if (bookList.length % size == 0 &&
          newbooks.length == size &&
          (bookList[bookList.length - 1].productID !=
              newbooks[size - 1].productID)) {
        print("salam");
        bookList.addAll(newbooks);
        page = page + 1;
      }

      _isloading = false;
    });
  }

  _fetchData() async {
     userService.initUser().then((e) {
       _refresh().then((value){
         setState(() {
            _loading = false;
          });
       });
          
        });
  }

  Future<Null> _refresh() {
    
    setState(() {
      _isloading = true;
    });
    return _bookService.getBooks(0, 4).then((e) {
      setState(() {
        if (e.length % 4 == 0)
          page = 1;
        else
          page = 0;
      
        this.bookList = e;
        _bookService.getImage(bookList[0].sellerID,  bookList[0].productID, 1).then((value) => print(value));
        
          _isloading = false;
      });
      print(bookList.length);
    });
  }

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
          title: Container(
              height: 50,
              child: Image.asset("images/logo_white/logo_white.png")),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ShoppingCart()),
                  );
                }),
          ],
        ),
        drawer: SahafDrawer(),
      body: (_loading)
            ? Container(  color: Colors.transparent,child:Center(child: CircularProgressIndicator(backgroundColor: Colors.white,)))
            : RefreshIndicator(
                onRefresh: () => _refresh(),
                key: _refreshIndicatorKey,
                child: ListView(
                  controller: _scrollController,
                  physics: AlwaysScrollableScrollPhysics(),
                  children: <Widget>[
                    HomePageCarousel(),
                    (bookList.length == 0)
                        ? Center(
                            child: Text(
                              "No book on sale",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ),
                          )
                        : GridView.builder(
                            physics: ScrollPhysics(),
                            itemCount: bookList.length,
                            shrinkWrap: true,
                            gridDelegate:
                                new SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemBuilder: (BuildContext context, int index) {
                              
                              return BookCard(
                              book: bookList[index]
                              );
                            }),
                    Container(
                      height: _isloading ? 50.0 : 0,
                      color: Colors.transparent,
                      child: Center(
                        child: new CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              )
    );
    
  }
}