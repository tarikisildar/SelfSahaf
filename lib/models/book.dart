class Book {
  String authorName;
  String name;
  String description;
  String language;
  String publisher;
  String imagePath;
  String categoryName;
  String isbn;
  String sellerName;
  int productID;
  int quantity;
  int price;
  int categoryID;
  int sellerID;
  Book(
      {this.authorName,
      this.name,
      this.description,
      this.language,
      this.publisher,
      this.imagePath,
      this.isbn,
      this.quantity,
      this.price,
      this.categoryID,
      this.sellerName});

  Map<String, dynamic> toJsonBook() {
    return {
      "author": authorName,
      "categories": [
        {"categoryID": categoryID}
      ],
      "description": description,
      "isbn": isbn,
      "language": language,
      "name": name,
      "imagePath": imagePath,
      "publisher": publisher
    };
  }
    Map<String, dynamic> toJsonBookUpdate() {
    return {
      "author": authorName,
      "categories": [
        {"categoryID": categoryID,
          "name": categoryName
        }
      ],
      "description": description,
      "isbn": isbn,
      "language": language,
      "name": name,
      "imagePath": imagePath,
      "publisher": publisher,
      "productID":productID,
      "sells":[

      ]
    };
  }

  Book.fromJson(Map<String, dynamic> json)
      : authorName = json['author'],
        productID = json['productID'],
        name = json['name'],
        description = json['description'],
        publisher = json['publisher'],
        price = json["sells"][0]['price'],
        quantity = json["sells"][0]['quantity'],
        isbn = json["isbn"],
        categoryName=json["categories"][0]["name"],
        imagePath=json["imagePath"],
        language=json["language"],
        sellerID=json["sells"][0]["sellerID"],
        categoryID=json["categories"][0]["categoryID"]
        ;
}
