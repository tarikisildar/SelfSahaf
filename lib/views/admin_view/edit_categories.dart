import 'package:Selfsahaf/models/category.dart';
import 'package:Selfsahaf/views/errors/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:Selfsahaf/controller/category_controller.dart';
import 'package:Selfsahaf/views/customer_view/category_view/category_card.dart';
import 'package:Selfsahaf/views/registration/input_field.dart';
import 'package:get_it/get_it.dart';

class EditCategories extends StatefulWidget {
  @override
  _EditCategoriesState createState() => _EditCategoriesState();
}

class _EditCategoriesState extends State<EditCategories> {
  CategoryService _categoryService = GetIt.I<CategoryService>();
  List<Category> _categories;

  _getCompanies(BuildContext context) async {
    _categoryService.getCategories().then((value) {
      if (!value.error) {
        setState(() {
          this._categories = value.data;
        });
      } else {
        ErrorDialog().showErrorDialog(context, "Error", value.errorMessage);
        setState(() {
          this._categories = value.data;
        });
      }
    });
  }

  Future<Null> _refresh() {
    return _categoryService.getCategories().then((value) {
      if (!value.error) {
        setState(() {
          this._categories = value.data;
        });
      } else {
        ErrorDialog().showErrorDialog(context, "Error", value.errorMessage);
        setState(() {
          this._categories = value.data;
        });
      }
    });
  }

  // _addCategory(BuildContext buildContext,String categoryName)async{
  //   _categoryService.addCategory(categoryName).then((value) {
  //                                 if(!value.error){
  //                                   _refresh();
  //                                   Navigator.pop(context);
  //                                 }
  //                                 else{
  //                                   setState(() {
  //                                         error=true;
  //                                         errorMessage=value.errorMessage;
  //                                   });
                                
  //                                   print(value.errorMessage);
  //                                 }
  //                               });
  // }
  
  
  final _formKey = GlobalKey<FormState>();

  void messagepopup(int val) {
    var _title;
    var _content;
    if (val == 0) {
      _title = "Hata!";
      _content = "Baglanti Hatasi";
    } else if (val == 1) {
      _title = "Mesaj";
      _content = "Kategori Kaydedildi";
    } else {
      _title = "Hata!";
      _content = "Gecersiz Kategori Ismi";
    }
    Navigator.of(context).pop();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            backgroundColor: Color(0xffe65100),
            title: Text(
              _title,
              style: TextStyle(color: Colors.white),
            ),
            content: Text(_content, style: TextStyle(color: Colors.white)),
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
  }

  CategoryService categoryApi = new CategoryService();
  TextEditingController categorynameController = TextEditingController();

  String categorynameValidation(String categoryname) {
    if (categoryname.length < 2) {
      return "Soyisim kismi bos birakilamaz.";
    } else
      return null;
  }

  @override
  Widget build(BuildContext widget) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back_ios)),
        title: Container(
            height: 50, child: Image.asset("images/logo_white/logo_white.png")),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Text(
                  "Edit Categories",
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
            ),
            Divider(
              thickness: 2,
              color: Colors.white,
            ),
            
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          return showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  backgroundColor: Color(0xffe65100),
                  title: Text(
                    "Add New Category",
                    style: TextStyle(color: Colors.white),
                  ),
                  content: SafeArea(
                    child: Form(
                      key: _formKey,
                      child: Container(
                        height: 100,
                        child: Column(
                          children: <Widget>[
                            Text(
                              "Category Name: ",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InputField(
                              validation: categorynameValidation,
                              controller: categorynameController,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  actions: <Widget>[
                    FlatButton(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Text(
                        "Ekle",
                        style: TextStyle(color: Color(0xffe65100)),
                      ),
                      onPressed: () {
                        if (categorynameController.text == "" ||
                            categorynameController.text == " ") {
                          messagepopup(2);
                        } else {
                          
                        }
                      },
                    ),
                    FlatButton(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Text(
                        "Vazgec",
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
        },
        elevation: 6,
        backgroundColor: Colors.white,
        child: InkWell(
          child: Icon(
            Icons.add,
            color: Color(0xffe65100),
          ),
        ),
      ),
    );
  }
}
