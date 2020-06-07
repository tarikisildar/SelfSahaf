import 'package:flutter/material.dart';
class ErrorDialog{
  void showErrorDialog(BuildContext context,errorTitle,errorMessage){
    showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                backgroundColor: Color(0xffe65100),
                title: Text(
                  errorTitle,
                  style: TextStyle(color: Colors.white),
                ),
                content: Text(errorMessage,
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
}