class Category{
  int categoryID;
  String categoryName;


Category.fromJson(Map<String, dynamic> json):
  categoryID=json["categoryID"],
  categoryName=json["name"];
  
}