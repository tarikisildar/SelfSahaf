import 'package:flutter/material.dart';
class CategoryCard extends StatefulWidget {
  final String categoryName;

  CategoryCard({
    @required this.categoryName,
  });

  @override
  _CategoryCardState createState() {
    return _CategoryCardState();
  }
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(25))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          
          children: <Widget>[
            Expanded(
              flex: 9,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                
                  "${widget.categoryName} ",
                  style: TextStyle(
                    color: Color(0xffe65100),
                    fontSize: 18,
                    
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
           
           
          ],
        ),
      ),
    );
  }
}
