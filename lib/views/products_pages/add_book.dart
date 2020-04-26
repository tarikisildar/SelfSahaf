import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:selfsahaf/views/products_pages/products_page.dart';
import 'package:selfsahaf/views/registration/input_field.dart';
import 'package:selfsahaf/controller/product_services.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:selfsahaf/models/category.dart';
import 'package:selfsahaf/models/book.dart';
import 'package:selfsahaf/controller/user_controller.dart';
import 'dart:convert';

class AddBook extends StatefulWidget {
  @override
  _AddBookState createState() => new _AddBookState();
}

class _AddBookState extends State<AddBook> {
  ProductService get productService => GetIt.I<ProductService>();
  AuthService get userService => GetIt.I<AuthService>();
  TextEditingController _booknameController = new TextEditingController();
  TextEditingController _isbnController = new TextEditingController();
  TextEditingController _authorController = new TextEditingController();
  TextEditingController _categoryController = new TextEditingController();
  TextEditingController _descriptionController = new TextEditingController();
  TextEditingController _priceController = new TextEditingController();
  TextEditingController _publisherController = new TextEditingController();
  TextEditingController _quantityController = new TextEditingController();
  List<Category> categories;
  Category selectedCategory;
  List<String> languages = ["TR", "EN", "DE", "FR", "AZ", "IT", "HE", "LA","RU"];
  String selectedLanguage;
  bool _isLoading = false;
  @override
  void initState() {
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

  String _booknameValidation(String email) {
    bool emailValid = false;
    if (email.length >= 5) emailValid = true;
    return emailValid ? null : 'not valid email.';
  }

  String _authorValidation(String author) {
    bool authorValid = false;
    if (author.length >= 2) authorValid = true;
    return authorValid ? null : 'not valid author name';
  }

  String _descriptionValidation(String description) {
    bool descValid = false;
    if (description.length >= 20) descValid = true;
    return descValid ? null : 'not valid description';
  }

  String _isbnValidation(String isbn) {
    bool isbnValid = false;
    if (isbn.length > 30 || isbn.length < 10) isbnValid = true;
    return isbnValid ? null : 'not valid isbn number';
  }

  String _publisherValidation(String pub) {
    bool pubValid = false;
    if (pub.length < 30 && pub.length > 1) pubValid = true;
    return pubValid ? null : 'not valid publisher name';
  }

  String _quantityValidation(String quantity) {
    bool qValid = false;
    if (quantity.length > 3 &&
        quantity.length < 1 &&
        !quantity.contains(RegExp(r'[A-Za-z]'))) qValid = true;
    return qValid ? null : 'not valid quantity';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffe65100),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(
            Icons.add,
            color: Color(0xffe65100),
          ),
          onPressed: () {
            if (_priceController.text != '' &&
                _descriptionController.text != '' &&
                selectedCategory != null &&
                _booknameController.text != '' &&
                _authorController.text != '' &&
                selectedLanguage != null &&
                _publisherController.text != null &&
                _quantityController.text != null &&
                _isbnController.text != null) {
              Book addedBook = Book(
                  categoryID: selectedCategory.categoryID,
                  authorName: _authorController.text,
                  description: _descriptionController.text,
                  imagePath: "/part1",
                  isbn: _isbnController.text,
                  quantity: int.parse(_quantityController.text),
                  language: selectedLanguage,
                  name: _booknameController.text,
                  price: int.parse(_priceController.text),
                  sellerName: userService.getUser().getUserName(),
                  publisher: _publisherController.text);
              productService
                  .addBook(addedBook, userService.getUser().userID)
                  .then((e) {
                Navigator.of(context).pop(addedBook);
              });
            }
          },
        ),
        appBar: AppBar(
          leading: InkWell(
              child: Icon(Icons.arrow_back),
              onTap: () {
                Navigator.pop(context);
              }),
          title: Container(
            height: 50,
            child: Image.asset("images/logo_white/logo_white.png"),
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  print("shopping");
                }),
          ],
        ),
        body: Builder(builder: (context) {
          if (_isLoading) {
            return CircularProgressIndicator();
          } else
            return Container(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.0, top: 12.0),
                        child: Text(
                          "Add New Book",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.0, top: 12.0),
                        child: InputField(
                          lines: 1,
                          validation: _booknameValidation,
                          controller: _booknameController,
                          labelText: "Book's Name",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: InputField(
                          lines: 1,
                          validation: _authorValidation,
                          controller: _authorController,
                          labelText: "Author's Name",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: InputField(
                          lines: 5,
                          validation: _descriptionValidation,
                          controller: _descriptionController,
                          labelText: "Description",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: InputField(
                          lines: 1,
                          controller: _priceController,
                          labelText: "Price",
                          validation: _booknameValidation,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: InputField(
                          lines: 1,
                          controller: _isbnController,
                          labelText: "ISBN",
                          validation: _isbnValidation,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: InputField(
                          lines: 1,
                          controller: _publisherController,
                          labelText: "Publisher",
                          validation: _publisherValidation,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: InputField(
                          lines: 1,
                          controller: _quantityController,
                          labelText: "Quantity",
                          validation: _quantityValidation,
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Theme(
                            data: ThemeData(
                                canvasColor: Color.fromRGBO(255, 144, 77, 1)),
                            child: SafeArea(
                              child: DropdownButton<Category>(
                                hint: Text(
                                  "Select a Category",
                                  style: TextStyle(color: Colors.white),
                                ),
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
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Theme(
                            data: ThemeData(
                                canvasColor: Color.fromRGBO(255, 144, 77, 1)),
                            child: SafeArea(
                              child: DropdownButton<String>(
                                hint: Text(
                                  "Select Book Language",
                                  style: TextStyle(color: Colors.white),
                                ),
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
                      Container(
                        height: 55,
                        width: 220,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 7.0, bottom: 3.0),
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                side: BorderSide(
                                    color: Color.fromRGBO(230, 81, 0, 1))),
                            child: Text(
                              "Add Photo",
                              style: TextStyle(color: Color(0xffe65100)),
                            ),
                            color: Colors.white,
                            onPressed: () {
                              print("resim cekme islemi");
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
        }));
  }
}
