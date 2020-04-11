import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:selfsahaf/controller/user_controller.dart';
import 'package:selfsahaf/views/admin_pages/admin_main_page.dart';
import 'package:selfsahaf/views/main_page/main_page.dart';
import 'input_field.dart';
import 'package:selfsahaf/views/registration/signup.dart';
import 'package:dio/dio.dart';
import 'package:selfsahaf/views/registration/input_field.dart';
import 'package:selfsahaf/models/user.dart';

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
      body: Container(
        child: SingleChildScrollView(
          child: Center(
              child: Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                  ),
                  Container(
                    width: 320,
                    height: 300,
                    child: Image.asset("images/logo_white/logo_white.png"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: InputField(
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
                      validation: passwrdValidation,
                      isPassword: true,
                      controller: _passwordController,
                      inputType: TextInputType.emailAddress,
                      labelText: "Sifre",
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
                        onPressed: () {
                          api.loginWithEmail(_emailController.text,
                                  _passwordController.text)
                              .then((val) {
                            if (val == 200) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MainPage()),
                                  ModalRoute.withName("/Home"));
                            }
                            else{
                              AlertDialog(
                                title: Text("hata"),
                              );
                            }
                          });
                        },
                        child: Text(
                          "Giris Yap",
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
                        onPressed: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Signup())),
                        child: Text(
                          "Kayit Ol",
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
                          "Sifremi Unuttum",
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
