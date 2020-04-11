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

  User(email,password){
    this.email=email;
    this.password=password;
  }

  Map<String,dynamic> toJson() =>{
    "email" : email,
    "password": password,
  };

  User.fromJson(Map<String, dynamic> json)
    : password = json['password'],
    email = json['email'];

}