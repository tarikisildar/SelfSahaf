import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final TextInputType inputType;
  final String labelText;
  final Icon suffixIcon;
  final bool isPassword;
  final TextEditingController controller;
  final Function validation;

  InputField(
      {this.inputType,
      @required this.controller,
      this.labelText,
      this.suffixIcon,
      this.isPassword = false,
      @required this.validation});

  @override
  State<StatefulWidget> createState() {
    return _InputFieldState();
  }
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      
      controller: widget.controller,
      validator: widget.validation,
      cursorColor: Colors.orange,
      obscureText: widget.isPassword,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        labelText: widget.labelText,
        suffixIcon: widget.suffixIcon,
        labelStyle: TextStyle(color: Colors.white),
        focusedBorder: OutlineInputBorder(
            
            borderSide: BorderSide(color: Colors.white, width: 3.0),
            borderRadius: new BorderRadius.circular(16.0)),
        enabledBorder: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(16.0),
          borderSide: new BorderSide(
            color: Colors.white,
            width: 3.0,
          ),
        ),
        errorBorder: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(16.0),
          borderSide: new BorderSide(
            color:Colors.white,
            width: 3.0,
          ),
        ),
        focusedErrorBorder: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(16.0),
          borderSide: new BorderSide(
            color:Colors.white,
            width: 3.0,
          ),
        )
      ),
    );
  }
}
