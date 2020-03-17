import 'package:flutter/material.dart';
import 'package:selfsahaf/registration/input_field.dart';
import 'package:selfsahaf/registration/signup.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  String emailValidation(String email) {
    bool emailValid =
        RegExp(r"^[a-zA-Z0-9.]+@([a-zA-Z0-9]+(\.))[a-zA-Z]+").hasMatch(email);
    return emailValid ? null : 'not valid email.';
  }

  String passwrdValidation(String passwrd) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[.!@#\$&*~]).{8,}$';
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
    return  Scaffold(
          backgroundColor: Colors.orange,
      body: Container(
        
        child: SingleChildScrollView(

          child: Center(
              child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                ),
                Container(
                  width: 300,
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
                    controller: _passController,
                    inputType: TextInputType.emailAddress,
                    labelText: "Sifre",
                    suffixIcon: Icon(
                      Icons.lock,
                      color: Colors.white,
                    ),
                    validation: emailValidation,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 35.0),

                  child: Container(
                    width: 220,
                    height: 45,
                    child: FlatButton(
                      shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(12.0),
                              side: BorderSide(
                                  color: Colors.orange)),
                      color: Colors.white,
                      onPressed: (){print("girdim aq");},
                      child: Text("Giris Yap", style:TextStyle(color: Colors.orange, fontSize: 20), 
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
                              borderRadius: new BorderRadius.circular(12.0),
                              side: BorderSide(
                                  color: Colors.orange)),
                      color: Colors.white,
                      onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Signup())),
                      child: Text("Kayit Ol", style:TextStyle(color: Colors.orange, fontSize: 20), 
                      ),
                    ),
                  ),
                ),
                 Padding(
                  padding: const EdgeInsets.only(top: 25.0),

                  child: Center(
                    
                    child: GestureDetector(
                      onTap: (){print("Sifremi unuttum aq");},
                      child: Text("Sifremi Unuttum", style:TextStyle(color: Colors.white, fontSize: 15), 
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
