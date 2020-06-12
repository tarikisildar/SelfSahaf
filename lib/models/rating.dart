class Rating{
  String comment;
  double rating;
  Rating({this.comment,this.rating});

  Rating.fromJson(Map<String, dynamic> json)
      : comment = json["comment"],
        rating = json["rating"];
        

}