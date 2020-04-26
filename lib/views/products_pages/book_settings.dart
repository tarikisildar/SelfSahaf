import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:selfsahaf/controller/user_controller.dart';
import 'package:selfsahaf/models/book.dart';
import 'package:selfsahaf/views/registration/input_field.dart';
import 'package:selfsahaf/controller/product_services.dart';
import 'package:selfsahaf/models/category.dart';

class BookSettingsPage extends StatefulWidget {
  final Book selectedBook;
  BookSettingsPage({@required this.selectedBook});
  @override
  _BookSettingsPage createState() => new _BookSettingsPage();
}

class _BookSettingsPage extends State<BookSettingsPage> {
  String _name, _surname, _email, _phoneNumber;

  AuthService userService = GetIt.I<AuthService>();
  ProductService productService = GetIt.I<ProductService>();

  bool _checkSeller = false;

  TextEditingController _sellerController;
  TextEditingController _bookNameController;
  TextEditingController _sellernameController;
  TextEditingController _authorController;
  TextEditingController _langController;
  TextEditingController _isbnController;
  TextEditingController _publisherController;
  TextEditingController _descController;
  TextEditingController _priceController;
  TextEditingController _quantityController;
  bool _edit = false;
  List<Category> categories;
  Category selectedCategory;
  List<String> languages = ["TR", "EN", "DE", "FR", "AZ", "IT", "HE", "LA"];
  String selectedLanguage;
  bool _isLoading = true;

  @override
  void initState() {
    print(widget.selectedBook.sellerName);
    _bookNameController = TextEditingController(text: widget.selectedBook.name);
    _priceController =
        TextEditingController(text: widget.selectedBook.price.toString());
    _authorController =
        TextEditingController(text: widget.selectedBook.authorName);
    _langController = TextEditingController(text: widget.selectedBook.language);
    _isbnController = TextEditingController(text: widget.selectedBook.isbn);
    _publisherController =
        TextEditingController(text: widget.selectedBook.publisher);
    _descController =
        TextEditingController(text: widget.selectedBook.description);
    _quantityController =
        TextEditingController(text: "${widget.selectedBook.quantity}");
     
      selectedLanguage=widget.selectedBook.language;
    _getCategories();
  }

  _getCategories() async {
    setState(() {
      _isLoading = true;
    });
    categories = await productService.getCategories();
    print(categories);
    setState(() {
      
      _isLoading = false;
    });
  }

  String bookNameValidation(String bookName) {
    bool booknameValid;
    if (bookName == "" || bookName == " ")
      return "Invalid Book Name";
    else
      return null;
  }

  String priceValidation(String price) {
    if (price.length == 0 || !price.contains(RegExp(r'[A-Za-z]')))
      return "Invalid Price";
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          print("sa");
        
          if (_bookNameController.text != null &&
              _isbnController.text != null &&
              _langController.text != null &&
              _priceController.text != null &&
              _publisherController.text != null &&
              _descController.text != null) {
            Book oldBook = widget.selectedBook;
            Book updatedBook = Book.bookForUpdate(
                authorName: _authorController.text,
                description: _descController.text,
                categoryID:selectedCategory.categoryID,
                categoryName: selectedCategory.categoryName,
                imagePath: oldBook.imagePath,
                isbn: _isbnController.text,
                language: selectedLanguage,
                name: _bookNameController.text,
                price: int.parse(_priceController.text),
                productID: oldBook.productID,
                publisher: _publisherController.text,
                quantity: int.parse(_quantityController.text),
                sellerName: userService.getUser().name);
            productService.updateBook(updatedBook).then((e) {
              if (e == 200) {
                Navigator.of(context).pop(updatedBook);
              }
            });
          }
        },
        child: Icon(
          Icons.save,
          color: Theme.of(context).primaryColor,
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Container(
            height: 50, child: Image.asset("images/logo_white/logo_white.png")),
      ),
      body: (_isLoading)
          ? Center(
              child: Container(
                  color: Theme.of(context).primaryColor,
                  width: double.infinity,
                  height: double.infinity,
                  child: CircularProgressIndicator()),
            )
          : Container(
              color: Theme.of(context).primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 5,
                            child: InputField(
                              labelText: "Book's Name",
                              controller: _bookNameController,
                              validation: bookNameValidation,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 5,
                            child: InputField(
                              labelText: "Price",
                              controller: _priceController,
                              validation: bookNameValidation,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 5,
                            child: InputField(
                              labelText: "Quantitiy",
                              controller: _quantityController,
                              validation: null,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 5,
                            child: InputField(
                              labelText: "Author",
                              controller: _authorController,
                              validation: bookNameValidation,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 5,
                            child: InputField(
                              labelText: "ISBN",
                              controller: _isbnController,
                              validation: bookNameValidation,
                            ),
                          ),
                        ],
                      ),
                    ),
                   
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 5,
                            child: InputField(
                              labelText: "Publisher",
                              controller: _publisherController,
                              validation: bookNameValidation,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(50, 0, 15,12),
                        child: Theme(
                          data: ThemeData(
                              canvasColor: Color.fromRGBO(255, 144, 77, 1)),
                          child: SafeArea(
                            child: DropdownButton<Category>(
                            hint: Text(widget.selectedBook.categoryName, style: TextStyle(color: Colors.white) ),
                              items: categories.map((Category dropdownItem) {
                                return DropdownMenuItem<Category>(
                                  value: dropdownItem,
                                  child: Text(
                                    dropdownItem.categoryName,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                );
                              }).toList(),
                              onChanged: (Category newValueSelected) {
                                setState(() {
                                  this.selectedCategory = newValueSelected;
                                });
                              },
                              value: this.selectedCategory,
                            ),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(50, 0, 15,12),
                        child: Theme(
                          data: ThemeData(
                              canvasColor: Color.fromRGBO(255, 144, 77, 1)),
                          child: SafeArea(
                            child: DropdownButton<String>(
                              
                              items: languages.map((String dropdownItem) {
                                return DropdownMenuItem<String>(
                                  value: dropdownItem,
                                  child: Text(
                                    dropdownItem,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String newValueSelected) {
                                setState(() {
                                  this.selectedLanguage = newValueSelected;
                                });
                              },
                              value: this.selectedLanguage,
                            ),
                          ),
                        )),
                  ],
                ),
              )),
    );
  }
}
