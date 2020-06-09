import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:Selfsahaf/views/registration/input_field.dart';
import 'package:Selfsahaf/controller/product_services.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:Selfsahaf/models/category.dart';
import 'package:Selfsahaf/models/book.dart';
import 'package:Selfsahaf/controller/user_controller.dart';
import 'dart:convert';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:carousel_slider/carousel_slider.dart';
import "package:http/http.dart" as http;
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
  List<File> _imagesList = new List();
  final picker = ImagePicker();
String condition;
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
    if (email.length >= 2) emailValid = true;
    return emailValid ? null : 'not valid book name.';
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

  Future getImage(ImageSource source) async {
    final pickedFile =
        await picker.getImage(source: source, maxHeight: 640, maxWidth: 640);
    setState(() {
      if (pickedFile != null) {
        _imagesList.add(File(pickedFile.path));
      }
      print("list size = ${_imagesList.length}");
    });
  }

  void clearImage(int index) {
    setState(() {
      _imagesList.removeAt(index);
      print(_imagesList.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffe65100),
        floatingActionButton: SpeedDial(
          elevation: 8.0,
          backgroundColor: Colors.white,
          closeManually: false,
          overlayOpacity: 0,
          curve: Curves.bounceIn,
          shape: CircleBorder(),
          tooltip: 'Speed Dial',
          heroTag: 'speed-dial-hero-tag',
          child: Icon(
            Icons.add_a_photo,
            color: Color(0xffe65100),
          ),
          children: [
            SpeedDialChild(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.photo_camera,
                color: Color(0xffe65100),
              ),
              label: "Camera",
              labelStyle: TextStyle(
                fontSize: 15.0,
              ),
              onTap: () => getImage(ImageSource.camera),
            ),
            SpeedDialChild(
                elevation: 8.0,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.photo_album,
                  color: Color(0xffe65100),
                ),
                label: "Gallery",
                labelStyle: TextStyle(
                  fontSize: 15.0,
                ),
                onTap: () => getImage(ImageSource.gallery)),
          ],
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
                        (_imagesList.length == 0)
                            ? Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
                                child: Text(
                                  "No photo selected",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              )
                            : CarouselSlider.builder(
                                itemCount: _imagesList.length,
                                itemBuilder: (BuildContext context,
                                        int itemIndex) =>
                                    Container(
                                        padding: EdgeInsets.only(bottom: 10),
                                        child: Stack(
                                          fit: StackFit.expand,
                                          children: <Widget>[
                                            Container(
                                              child: Image.file(
                                                _imagesList[itemIndex],
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.topRight,
                                              child: IconButton(
                                                  icon: Icon(
                                                    Icons.cancel,
                                                    size: 35,
                                                    color: Colors.white,
                                                  ),
                                                  onPressed: () =>
                                                      clearImage(itemIndex)),
                                            ),
                                          ],
                                        )),
                                options: CarouselOptions(
                                  autoPlay: false,
                                  enableInfiniteScroll: false,
                                  initialPage: 0,
                                  enlargeCenterPage: true,
                                )),
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
                            Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: Theme(
                              data: ThemeData(
                                  canvasColor: Color.fromRGBO(255, 144, 77, 1)),
                              child: SafeArea(
                                child: DropdownButton<String>(
                                  hint: Text(
                                    "Select Condition",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  items: ["NEW","SECONDHAND"].map((String dropdownItem) {
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
                                      this.condition= newValueSelected;
                                    });
                                  },
                                  value: this.condition,
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
                                  "Add Book",
                                  style: TextStyle(color: Color(0xffe65100)),
                                ),
                                color: Colors.white,
                                onPressed: () {
                                  if (_formKey.currentState.validate() &&
                                      selectedCategory != null &&
                                      selectedLanguage != null &&this.condition!=null&&
                                      _imagesList.length != 0) {
                                    Book addedBook = Book(
                                        categoryID: selectedCategory.categoryID,
                                        authorName: _authorController.text,
                                        description:
                                            _descriptionController.text,
                                        imagePath: "/part1",
                                        isbn: _isbnController.text,
                                        quantity:
                                            int.parse(_quantityController.text),
                                        language: selectedLanguage,
                                        condition: this.condition,
                                        status: "ACTIVE",
                                        name: _booknameController.text,
                                        price: double.parse(_priceController.text),
                                        sellerName:
                                            userService.getUser().getUserName(),
                                        publisher: _publisherController.text);
                                    productService
                                        .addBook(addedBook,
                                            userService.getUser().userID)
                                        .then((e) {
                                       productService.uploadImages(_imagesList, e).then((value){
                                         if(value==200)
                                           Navigator.of(context).pop(addedBook);
                                          else{
                                            productService.deleteBook(e);
                                          print("HATA");
                                          print(value);
                                          print(e);
                                          }
                                       });
                                    
                                    });
                                  } else if (selectedLanguage == null ||
                                      selectedCategory == null ||
                                      _imagesList.length == 0) {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                            ),
                                            backgroundColor: Color(0xffe65100),
                                            title: Text(
                                              "Error!",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            content: (_imagesList.length == 0)
                                                ? Text(
                                                    "Please select an image or images",
                                                    style: TextStyle(
                                                        color: Colors.white))
                                                : Text(
                                                    "Please select category or language.",
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                            actions: <Widget>[
                                              FlatButton(
                                                color: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                ),
                                                child: Text(
                                                  "Tamam",
                                                  style: TextStyle(
                                                      color: Color(0xffe65100)),
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
                                }),
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
