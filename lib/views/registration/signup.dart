import 'package:flutter/material.dart';
import 'input_field.dart';

import 'login.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _fnameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _passController = TextEditingController();
  final _passCheckController = TextEditingController();
  bool _kvkk = false;

  String fnameValidation(String fullname) {
    if(fullname == ""){
      return "Isim kismi bos birakilamaz.";
    }
  }
  String surnameValidation(String fullname) {
    if(fullname == ""){
      return "Soyisim kismi bos birakilamaz.";
    }
  }

  String telephoneNumberValidation(String number) {
    bool numberValid =
        RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[\s/0-9]*$').hasMatch(number);
    return numberValid ? null : "Lütfen geçerli bir telefon numarası giriniz.";
  }

  String emailValidation(String email) {
    bool emailValid =
        RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
    return emailValid ? null : "Lütfen geçerli bir mail adresi giriniz.";
  }

  String passwrdValidation(String passwrd) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[.!@#\$&*~]).{8,24}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(passwrd)
        ? null
        : "Lütfen geçerli bir şifre giriniz.";
  }

  bool doppelValidation(String random, String random2) {
    if (random.compareTo(random2) == 0) {
      return true;
    } else {
      return false;
    }
  }

  /*String message(statusCode) {
    if (statusCode == 409) {
      return "Girdiğiniz E-mail kullanılmaktadır!\nLütfen başka bir E-mail giriniz.";
    } else {
      return "Bağlantı Hatası\nLütfen daha sonra tekrar deneyiniz.";
    }
  }*/

  /*_showDialog(statusCode) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: new Text(
              message(statusCode),
              style: TextStyle(fontSize: 25),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            actions: <Widget>[
              new FlatButton(
                child: new Text(
                  "Tamam",
                  style: TextStyle(fontSize: 25),
                ),
                onPressed: () {
                  
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }*/

  // Checks if the state has any error
  // if not it navigates the user to the user profile
  /*void afterBuild(state) {
    if (state is SignupLoading && !state.signupError) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Welcome()),
          (Route<dynamic> route) => false);
    } else if (state.signupError) {
      //_showDialog(state.statusCode);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Welcome()),
          (Route<dynamic> route) => false);
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(230,81,0,1),
      key: _scaffoldKey,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0),
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(height: 5.0),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, left: 13.0, right: 13.0),
                      child: Container(
                          child: Image.asset(
                            "images/logo_white/logo_white.png",
                            fit: BoxFit.contain,
                          ),
                          height: 100.0,
                          width: 100.0),
                    ),
                    SizedBox(height: 20.0),
                    InputField(
                      controller: _fnameController,
                      inputType: TextInputType.text,
                      validation: fnameValidation,
                      labelText: "Adiniz",
                      suffixIcon: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 12.0),
                    InputField(
                      controller: _surnameController,
                      inputType: TextInputType.text,
                      validation: surnameValidation,
                      labelText: "Soyadiniz",
                      suffixIcon: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 12.0),
                    InputField(
                      controller: _emailController,
                      inputType: TextInputType.emailAddress,
                      validation: emailValidation,
                      labelText: "Email",
                      suffixIcon: Icon(
                        Icons.mail,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 12.0),
                    InputField(
                      controller: _phoneController,
                      inputType: TextInputType.phone,
                      validation: telephoneNumberValidation,
                      labelText: "Telefon Numarasi",
                      suffixIcon: Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 12.0),
                    InputField(
                      controller: _passController,
                      inputType: TextInputType.visiblePassword,
                      validation: passwrdValidation,
                      labelText: "Sifre",
                      isPassword: true,
                      suffixIcon: Icon(
                        Icons.lock,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 12.0),
                    InputField(
                      controller: _passCheckController,
                      inputType: TextInputType.visiblePassword,
                      validation: passwrdValidation,
                      isPassword: true,
                      labelText: "Sifrenizi Yeniden Yazınız",
                      suffixIcon: Icon(
                        Icons.verified_user,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Row(children: <Widget>[
                      Checkbox(
                        activeColor: Colors.white,
                        checkColor: Colors.white,
                        onChanged: (bool value) {
                          setState(() => this._kvkk = value);
                        },
                        value: this._kvkk,
                      ),
                      Text(
                        "KVKK kapsamı doğrultusundaki aydınlatma\n metnini okuyup kabul ettim.",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontStyle: FontStyle.italic),
                      ),
                    ]),
                    SizedBox(height: 12.0),
                    Container(
                        width: 80.0,
                        height: 50.0,
                        child: FlatButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(12.0),
                              side: BorderSide(color: Colors.white)),
                          color: Colors.white,
                          child: Text(
                            "Kayıt Ol",
                            style:
                                TextStyle(color: Color.fromRGBO(230,81,0,1), fontSize: 20.0),
                          ),
                          onPressed: () {
                            CircularProgressIndicator();
                            if (doppelValidation(_passController.value.text,
                                    _passCheckController.value.text) &&
                                _kvkk) {
                              if (_formKey.currentState.validate()) {
                                print("kayitoldum");
                              }
                            } else if (!_kvkk) {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                backgroundColor: Colors.white,
                                content: Text(
                                  "Lütfen KVKK sözleşmesini kabul ediniz!",
                                  style: TextStyle(
                                      color: Color.fromRGBO(230,81,0,1), fontSize: 18),
                                ),
                                duration: Duration(seconds: 2),
                              ));
                            } else {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                backgroundColor: Colors.white,
                                content: Text(
                                  "Şifreler Uyuşmuyor!",
                                  style: TextStyle(
                                      color: Color.fromRGBO(230,81,0,1), fontSize: 18),
                                ),
                              ));
                            }
                          },
                        )),
                    SizedBox(height: 30.0),
                    Center(
                        child: GestureDetector(
                            child: Text("Zaten üye misiniz? Giriş Yap",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            })),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
