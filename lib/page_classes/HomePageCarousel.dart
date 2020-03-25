import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';


class HomePageCarousel extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    Widget carouselImages=new Container(
      height: 200,
      child: new Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage("images/carousel/kitap1.png"),
          AssetImage("images/carousel/kitap2.jpg"),
          AssetImage("images/carousel/kitap3.jpg"),
          AssetImage("images/carousel/kitap4.jpg"),
          
        ],
        autoplay: true,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 1000),
      ),

    );
    return carouselImages ;
  }


}
