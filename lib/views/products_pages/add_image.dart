import "package:flutter/material.dart";
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';
class AddImage extends StatefulWidget{
  @override
  _AddImageState createState() {
   return _AddImageState();
  }

}
class _AddImageState extends State<AddImage>{
  File _image;
  final picker = ImagePicker();
   Future getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    setState(() {
      _image = File(pickedFile.path);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffe65100),
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
        ),
        bottomNavigationBar: BottomAppBar(child: Row(
          children: <Widget>[
            IconButton(icon: Icon(Icons.photo_camera), onPressed:()=>getImage(ImageSource.camera)),
            IconButton(icon: Icon(Icons.photo_library), onPressed:()=>getImage(ImageSource.gallery)),
          ],
        ),),
        body: Center(
        child: _image == null
            ? Text('No image selected.')
            : Image.file(_image),
      ),
    );
  }

}