

class User{
  int userID;
  String name;
  String password;
  String surname;
  String dateOfBirth;
  String phoneNumber;
  String email;
  String role;
  int sellerAddressID;

  User({mail, name,surname,password,dob}){
    this.email=mail;
    this.password=password;
    this.surname = surname;
    this.name = name;
    this.dateOfBirth = dob;
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
    email = json['email'];

}