import 'package:flutter/material.dart';
import 'package:selfsahaf/views/customer_view/category_view/category_card.dart';

class EditCategories extends StatefulWidget{
  @override
  _EditCategoriesState createState() => _EditCategoriesState();
}

class _EditCategoriesState extends State<EditCategories>{
  @override
  Widget build(BuildContext widget){
    return Scaffold(
      appBar: AppBar(
          title: Container(
            height: 22,
            child: Image.asset("images/selfadmin_logo/selfadmin.png"),
          ),
          leading: InkWell(
            child: Icon(Icons.arrow_back_ios,color: Colors.white,),
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
                  child: Text("Edit Categories",style: TextStyle(fontSize: 24,color: Colors.white),),
                  
                ),
              ),
              Divider(thickness: 2, color: Colors.white,),
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    CategoryCard(categoryName: "Sci-Fi",),
                    CategoryCard(categoryName: "Novel",),
                    CategoryCard(categoryName: "Fantasy",),
                    CategoryCard(categoryName: "Dictionary",),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
}