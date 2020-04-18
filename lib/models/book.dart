class Book {
  String authorName;
  String name;
  String description;
  String language;
  String publisher;
  String imagePath;
  String categoryName;
  String isbn;
  int productID;
  int quantity;
  int price;
  int categoryID;
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
      this.categoryID});

  Map<String,dynamic> toJsonBook() =>{
    "author" : authorName,
    "productID": productID,
    "name" : name,
    "description" : description,
    "publisher" : publisher,
    "price" : price,
    "imagePath" : imagePath
  };

  Book.fromJson(Map<String, dynamic> json)
    : authorName = json['author'],
    productID = json['productID'],
    name = json['name'],
    description = json['description'],
    publisher = json['publisher'],
    price = json['price'];


}