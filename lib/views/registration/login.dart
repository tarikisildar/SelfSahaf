import 'package:flutter/material.dart';
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
  final _passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  var response;
 void postUser() async{
   var url='http://142.93.106.79:8080/accessing-data-mysql/demo/login';
    this.response = await http.post(url, body: {"email":_emailController.text,"password":_passController.text});
  print('Response status: ${response.statusCode}');
 } 
  String emailValidation(String email) {
    //.tr .edu.tr eklenecek
    bool emailValid =
        RegExp(r"^[a-zA-Z0-9.]+@([a-zA-Z0-9]+(\.))[a-zA-Z]+").hasMatch(email);
    return emailValid ? null : 'not valid email.';
  }

  String passwrdValidation(String passwrd) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[.!@#\$&*~]).{8,24}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(passwrd) ? null : 'not valid password';
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
                      controller: TextEditingController(),
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
                      isPassword: true,
                      controller: _passController,
                      inputType: TextInputType.emailAddress,
                      labelText: "Sifre",
                      suffixIcon: Icon(
                        Icons.lock,
                        color: Colors.white,
                      ),
                      validation: passwrdValidation,
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
                            side:
                                BorderSide(color: Color.fromRGBO(230, 81, 0, 1))),
                        color: Colors.white,
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainPage()));
                        } else {
                          postUser();
                        }
                        },
                        child: Text(
                          "Giris Yap",
                          style: TextStyle(
                              color: Color.fromRGBO(230, 81, 0, 1), fontSize: 20),
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
                            side:
                                BorderSide(color: Color.fromRGBO(230, 81, 0, 1))),
                        color: Colors.white,
                        onPressed: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Signup())),
                        child: Text(
                          "Kayit Ol",
                          style: TextStyle(
                              color: Color.fromRGBO(230, 81, 0, 1), fontSize: 20),
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
