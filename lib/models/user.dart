

import 'package:selfsahaf/models/address.dart';

class User{
  int userID;
  String name;
  String password;
  String surname;
  String dateOfBirth;
  String phoneNumber;
  String email;
  String role;
  Address sellerAddressID;
  List<Address> addresses;


  User({mail, name,surname,password,dob}){
    this.email=mail;
    this.password=password;
    this.surname = surname;
    this.name = name;
    this.dateOfBirth = dob;
  }
  String getUserName(){
    return this.name+" "+this.surname;
  }
  Map<String,dynamic> toJsonsignup() =>{
    "email" : email,
    "password": password,
    "surname" : surname,
    "dob" : dateOfBirth,
    "name" : name,
    "phoneNumber" : phoneNumber,
  };


  User.fromJson(Map<String, dynamic> json)
    : password = json['password'],
    email = json['email'],
    name=json["name"],
    surname=json["surname"],
    dateOfBirth=json["dob"],
    phoneNumber=json["phoneNumber"],
    sellerAddressID=json["sellerAddressID"],
    addresses=json["addresses"]
    ;

}