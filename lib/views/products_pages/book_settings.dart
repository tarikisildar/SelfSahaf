import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:selfsahaf/controller/user_controller.dart';
import 'package:selfsahaf/models/book.dart';
import 'package:selfsahaf/views/registration/input_field.dart';

class BookSettingsPage extends StatefulWidget {
  final Book selectedBook;
  BookSettingsPage({@required this.selectedBook});
  @override
  _BookSettingsPage createState() => new _BookSettingsPage();
}

class _BookSettingsPage extends State<BookSettingsPage> {
  String _name, _surname, _email, _phoneNumber;

  AuthService userService = GetIt.I<AuthService>();

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

  @override
  void initState() {

    _bookNameController =
        TextEditingController(text: widget.selectedBook.name);
    _priceController =
        TextEditingController(text: widget.selectedBook.price.toString());
    _authorController =
        TextEditingController(text: widget.selectedBook.authorName);
    _langController = 
        TextEditingController(text: widget.selectedBook.language);
    _isbnController =
        TextEditingController(text: widget.selectedBook.isbn);
    _publisherController =
        TextEditingController(text: widget.selectedBook.publisher);
    _descController =
        TextEditingController(text: widget.selectedBook.description);

  }

  String bookNameValidation(String bookName) {
    bool booknameValid;
    if (bookName == "" || bookName == " ")
      return "Invalid Book Name";
    else
      return null;
  }
  String priceValidation(String price){
    if(price.length == 0 || !price.contains(RegExp(r'[A-Za-z]'))) return "Invalid Price";
    else return null;
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {},
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
      body: Container(
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
                          labelText: "Language",
                          controller: _langController,
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
              ],
            ),
          )),
    );
  }
}