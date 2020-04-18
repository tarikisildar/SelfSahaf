class Book {
  String authorName;
  String name;
  String description;
  String language;
  String publisher;
  String imagePath;
  String categoryName;
  String isbn;
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

  Map<String, dynamic> toJsonBook() {
    return {
  "author": authorName,
  "categories": [
    {
      "categoryID": categoryID
    }
  ],
  "description": description,
  "isbn": isbn,
  "language": language,
  "name": name,
  "path": {
    "path": imagePath
  },
  "publisher": publisher
};
  }
  }