import 'package:flutter/material.dart';

class BookCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BookCardState();
  }
}

class _BookCardState extends State<BookCard> {
  var bookList = [
    {
      "name": "1984",
      "picture": "images/sell/1984.jpg",
      "writer": "George Orwell",
      "price": "\$10",
      "seller": "Ali Osman Kocaman",
    },
    {
      "name": "A Clash Of Kings",
      "picture": "images/sell/clashOfKings.jpg",
      "writer": "George R.R. Martin",
      "price": "\$15",
      "seller": "Tarık",
    },
    {
      "name": "Fire And Blood",
      "picture": "images/sell/fireAndBlood.jpg",
      "writer": "George Orwell",
      "price": "\$20",
      "seller": "Fatih",
    },
    {
      "name": "LONTANO",
      "picture": "images/sell/lontano.jpg",
      "writer": "Jean Christophe Grange",
      "price": "\$5",
      "seller": "Barkın",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: bookList.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Book(
            bookName: bookList[index]['name'],
            picture: bookList[index]['picture'],
            price: bookList[index]['price'],
            seller: bookList[index]['seller'],
            writer: bookList[index]['writer'],
          );
        });
  }
}

class Book extends StatelessWidget {
  final String bookName;
  final String picture;
  final String writer;
  final String price;
  final String seller;
  Book({this.bookName, this.picture, this.price, this.seller, this.writer});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Hero(
      tag: bookName,
      child: Padding(
        child: InkWell(
          onTap: () {},
          child: GridTile(
            footer: Container(
                width: 50,
                color: Colors.white70,
                child: Column(
                  children: <Widget>[
                    Text(bookName,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                       
                        Row(
                        children:<Widget>[
                          Text(
                            writer,
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.w800),
                          ),
                          Padding(padding: EdgeInsets.all(5.0))
                          ,
                           Text(
                            price,
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.w800),
                          ),]
                        ),
                    
                    Text(
                          seller,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w800),
                        ),
                  ],
                )),
            child: Image.asset(picture, fit: BoxFit.cover),
          ),
        ),
        padding: EdgeInsets.all(2.0),
      ),
    ));
  }
}
