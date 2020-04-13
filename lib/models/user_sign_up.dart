class UserSignUp{
  String name;
  String password;
  String surname;
  String dateOfBirth;
  String phoneNumber;
  String email;
  String role;

  UserSignUp({this.name,this.surname,this.email,this.phoneNumber,this.dateOfBirth});

  Map<String,dynamic> toJson() =>{
    "name":this.name,
    "surname":this.surname,
    "addresses":[],
    "cards":[],
    "dob":this.dateOfBirth,
    "email" : this.email,
    "password": this.password,
    "orderdetails":[],
    "phoneNumber":this.phoneNumber,
    "role":null,
    "sellerAddressID":null,
    "sells":[],
  };
/*
  User.fromJson(Map<String, dynamic> json)
    : password = json['password'],
    email = json['email'];
*/
}