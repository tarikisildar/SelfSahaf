import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:selfsahaf/controller/user_controller.dart';
import 'package:selfsahaf/views/main_page/main_page.dart';
import 'input_field.dart';
import 'package:selfsahaf/views/registration/signup.dart';
import 'package:dio/dio.dart';
import 'package:selfsahaf/views/registration/input_field.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  var _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  AuthService api = new AuthService();

  void _login() async {
    api
        .loginWithEmail(_emailController.text, _passwordController.text)
        .then((val) {
      if (val == 200 || val == 302) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MainPage()),
            ModalRoute.withName("/Home"));
      } else
        return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                backgroundColor: Color(0xffe65100),
                title: Text(
                  "Hata!",
                  style: TextStyle(color: Colors.white),
                ),
                content: Text("Girdiğiniz E-Mail veya Şifre Hatalıdır.",
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
    });
  }

  String emailValidation(String email) {
    bool emailValid =
        RegExp(r"^[a-zA-Z0-9.]+@([a-zA-Z0-9]+(\.))[a-zA-Z.]+").hasMatch(email);
    return emailValid ? null : 'not valid email.';
  }

  String passwrdValidation(String passwrd) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[.!@#\$&*~]).{8,24}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(passwrd) ? null : "not valid password";
  }

  String message(statusCode) {
    if (statusCode == 401) {
      return "Girdiğiniz E-mail veya Şifre Hatalıdır";
    } else {
      return "Bağlantı Hatası\nlütfen daha sonra tekrar deneyiniz.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(230, 81, 0, 1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
              child: Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30),
                    ),
                  ),
                  Container(
                    height: 150,
                    child: Image.asset("images/logo_white/logo_white.png"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: InputField(
                      lines: 1,
                      controller: _emailController,
                      inputType: TextInputType.emailAddress,
                      labelText: "Email",
                      suffixIcon: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      validation: emailValidation,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: InputField(
                      lines: 1,
                      validation: passwrdValidation,
                      isPassword: true,
                      controller: _passwordController,
                      inputType: TextInputType.emailAddress,
                      labelText: "Password",
                      suffixIcon: Icon(
                        Icons.lock,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 35.0),
                    child: Container(
                      width: 220,
                      height: 45,
                      child: FlatButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(15.0),
                            side: BorderSide(
                                color: Color.fromRGBO(230, 81, 0, 1))),
                        color: Colors.white,
                        onPressed: ()async { //@TODO : degistir bunu 
                          _login();
                          /*if (_formKey.currentState.validate()) {
                            
                          } else {
                            print("not valid.");
                          }*/
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Color.fromRGBO(230, 81, 0, 1),
                              fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Container(
                      width: 220,
                      height: 45,
                      child: FlatButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(15.0),
                            side: BorderSide(
                                color: Color.fromRGBO(230, 81, 0, 1))),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => Signup()),
                              ModalRoute.withName("/guider"));
                        },
                        child: Text(
                          "Signup",
                          style: TextStyle(
                              color: Color.fromRGBO(230, 81, 0, 1),
                              fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          print("Sifremi unuttum aq");
                        },
                        child: Text(
                          "Forgot My Password",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }
}
