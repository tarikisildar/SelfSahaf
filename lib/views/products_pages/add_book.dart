import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:selfsahaf/views/registration/input_field.dart';
import 'package:selfsahaf/controller/product_services.dart';
import 'package:selfsahaf/models/category.dart';
import 'package:selfsahaf/models/book.dart';
import 'package:selfsahaf/controller/user_controller.dart';


class AddBook extends StatefulWidget {
  @override
  _AddBookState createState() => new _AddBookState();
}

class _AddBookState extends State<AddBook> {
  final _formKey = GlobalKey<FormState>();
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
  List<String> languages = [
    "TR",
    "EN",
    "DE",
    "FR",
    "AZ",
    "IT",
    "HE",
    "LA",
    "RU"
  ];
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

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  String _priceValidation(String price) {
    bool priceValid = false;
    if (!isNumeric(price)) return "price should be number";
    if (price.length > 0 && price.length < 4) {
      priceValid = true;
      if (int.parse(price) <= 0)
        return "price can not be less then or equal zero";
    }
    if (price.length >= 4) return "price is max 3 character";

    return priceValid ? null : 'not valid price';
  }

  String _isbnValidation(String isbn) {
    bool isbnValid = false;
    if (isbn.length > 10) isbnValid = true;

    return isbnValid ? null : 'not valid isbn number';
  }

  String _publisherValidation(String pub) {
    bool pubValid = false;
    if (pub.length < 30 && pub.length > 1) pubValid = true;
    return pubValid ? null : 'not valid publisher name';
  }

  String _quantityValidation(String quantity) {

     if (!isNumeric(quantity)) return "quantity should be number";
    bool qValid = false;
    if (quantity.length > 0 && quantity.length < 3) {
      qValid = true;

      if (int.parse(quantity) <= 0)
        return "quantitiy can not be less then or equal zero";
    }
    if (quantity.length >= 3) return "quantity is max 2 character";
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
            if (_formKey.currentState.validate() &&
                selectedCategory != null &&
                selectedLanguage != null) {
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
            } else if (selectedLanguage == null || selectedCategory == null) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      backgroundColor: Color(0xffe65100),
                      title: Text(
                        "Error!",
                        style: TextStyle(color: Colors.white),
                      ),
                      content: Text("Please select category or language.",
                          style: TextStyle(color: Colors.white)),
                      actions: <Widget>[
                        FlatButton(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Text(
                            "Tamam",
                            style: TextStyle(color: Color(0xffe65100)),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    );
                  });
            } else {
              print("bu olmaz");
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: 12.0, top: 12.0),
                          child: Text(
                            "Add New Book",
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: 12.0, top: 12.0),
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
                            inputType: TextInputType.number,
                            validation: _priceValidation,
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
                            inputType: TextInputType.number,
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
                                  items:
                                      categories.map((Category dropdownItem) {
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
                            padding:
                                const EdgeInsets.only(top: 7.0, bottom: 3.0),
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
              ),
            );
        }));
  }
}
