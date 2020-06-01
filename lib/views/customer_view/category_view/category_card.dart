import 'package:flutter/material.dart';
import 'package:selfsahaf/models/book.dart';

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
              flex: 7,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  "${widget.categoryName} ",
                  style: TextStyle(
                    color: Color(0xffe65100),
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: InkWell(
                onTap: () {},
                child: Icon(
                  Icons.edit,
                  color: Color(0xffe65100),
                  size: 40,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: InkWell(
                onTap: () {},
                child: Icon(
                  Icons.delete,
                  color: Color(0xffe65100),
                  size: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
