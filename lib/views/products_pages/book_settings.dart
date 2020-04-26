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
  final _formKey = GlobalKey<FormState>();
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
  List<String> languages = ["TR", "EN", "DE", "FR", "AZ", "IT", "HE", "LA","RU"];
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
      _descController = TextEditingController(text: widget.selectedBook.description);
     
      selectedLanguage=widget.selectedBook.language;
    _getCategories();
  }

  _getCategories() async {
    setState(() {
      _isLoading = true;
    });
    categories = await productService.getCategories();
    setState(() {
      for(int i =0;i<categories.length;i++){
        if(categories[i].categoryID==widget.selectedBook.categoryID){
          selectedCategory=categories[i];
          break;
        }
      }
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

  String _priceValidation(String price) {
    bool priceValid = false;
    if (price.length >= 0) priceValid = true;
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
    bool qValid = false;
    if (quantity.length>0) qValid = true;
    return qValid ? null : 'not valid quantity';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          print("sa");
        
          if (_formKey.currentState.validate()) {
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
          // else{
          //   showDialog(
          //   context: context,
          //   builder: (context) {
          //     return AlertDialog(
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(30.0),
          //       ),
          //       backgroundColor: Color(0xffe65100),
          //       title: Text(
          //         "Error!",
          //         style: TextStyle(color: Colors.white),
          //       ),
          //       content: Text("You can not give any field empty.",
          //           style: TextStyle(color: Colors.white)),
          //       actions: <Widget>[
          //         FlatButton(
          //           color: Colors.white,
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(30.0),
          //           ),
          //           child: Text(
          //             "Tamam",
          //             style: TextStyle(color: Color(0xffe65100)),
          //           ),
          //           onPressed: () {
          //             Navigator.of(context).pop();
          //           },
          //         ),
          //         SizedBox(
          //           width: 5,
          //         ),
          //       ],
          //     );
          //   });
          // }
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
              child: Form(
                key: _formKey,
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
                                labelText: "Name",
                                controller: _bookNameController,
                                validation: _booknameValidation,
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
                                inputType: TextInputType.number,
                                validation: _priceValidation,
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
                                inputType: TextInputType.number,
                                validation: _quantityValidation,
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
                                validation: _authorValidation,
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
                                lines: 5,
                                labelText: "Description",
                                controller: _descController,
                                validation: _descriptionValidation,
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
                                validation: _isbnValidation,
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
                                validation: _publisherValidation,
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
                ),
              )),
    );
  }
}
