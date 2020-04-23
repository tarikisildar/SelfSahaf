class Category{
  int categoryID;
  String categoryName;
Category({this.categoryName,this.categoryID});


Category.fromJson(Map<String, dynamic> json):
  categoryID=json["categoryID"],
  categoryName=json["name"];
  
}