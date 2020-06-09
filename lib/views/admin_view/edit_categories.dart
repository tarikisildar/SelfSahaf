import 'package:flutter/material.dart';
import 'package:selfsahaf/controller/category_controller.dart';
import 'package:selfsahaf/views/customer_view/category_view/category_card.dart';
import 'package:selfsahaf/views/registration/input_field.dart';

class EditCategories extends StatefulWidget {
  @override
  _EditCategoriesState createState() => _EditCategoriesState();
}

class _EditCategoriesState extends State<EditCategories> {

  CategoryService api = CategoryService();
  final _formKey = GlobalKey<FormState>();

  void messagepopup(int val){
    var _title;
    var _content;
    if(val==0){
      _title = "Hata!";
      _content = "Baglanti Hatasi";
    }
    else if (val == 1){
      _title = "Mesaj";
      _content = "Kategori Kaydedildi";
    }
    else{
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
                content: Text(_content,
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
  }

  void _addCategory() async {
    api
        .addCategory(categorynameController.text)
        .then((val) {
      if (val>=400) {
        
        messagepopup(0);
      } else
        return messagepopup(1);
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
        title: Container(
          height: 22,
          child: Image.asset("images/selfadmin_logo/selfadmin.png"),
        ),
        leading: InkWell(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
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
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  CategoryCard(
                    categoryName: "Sci-Fi",
                  ),
                  CategoryCard(
                    categoryName: "Novel",
                  ),
                  CategoryCard(
                    categoryName: "Fantasy",
                  ),
                  CategoryCard(
                    categoryName: "Dictionary",
                  ),
                ],
              ),
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
                        if(categorynameController.text == "" || categorynameController.text == " "){
                          messagepopup(2);
                        }
                        else{
                          _addCategory();
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

