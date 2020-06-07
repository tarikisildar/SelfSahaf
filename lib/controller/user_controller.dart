import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:selfsahaf/models/user.dart';
import 'package:selfsahaf/models/api_response.dart';
import 'package:selfsahaf/controller/generalServices.dart';
import 'package:selfsahaf/models/address.dart';

class AuthService extends GeneralServices {
  Dio _dio;
  User _user;
  AuthService() {
    _dio = super.dio;
  }
  Future<APIResponse<int>> loginWithEmail(String email, String password) async {
    try {
      Response response = await _dio.post(
        "login?email=" + email + "&password=" + password,
      );
      if(response.statusCode==403)
        return APIResponse<int>(data: response.statusCode , error: true, errorMessage: "Email or password is wrong!") ;

      return APIResponse<int>(data: response.statusCode ) ;
    } on DioError catch (e) {

       if (e.response != null) {
         print(e.response.statusCode);
        return APIResponse<int>(data: e.response.statusCode, error: true, errorMessage: e.response.data) ;
      } else {
         print(e);
        //server is crashed
        if(e.type==DioErrorType.CONNECT_TIMEOUT){
          return APIResponse<int>(data: 500, errorMessage: "Connection Timeout", error: true);
        }
        // internet is not open
        if(e.type== DioErrorType.DEFAULT){
          return APIResponse<int>(data: 101, errorMessage: "Internet is not avaible.", error: true);
        }
        return APIResponse<int>(data: -1, errorMessage: "Some error occurs.", error: true);
      }
    }
  }

  Future<APIResponse<String>> signup(data) async {
    try {
      Response response = await _dio.post("user/add", data: data);
        
         return APIResponse<String>(data: response.data.toString()) ;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
        return APIResponse<String>(data: e.response.statusMessage,error:true, errorMessage: e.response.statusMessage);
      } else {
        //server is crashed
        if(e.type==DioErrorType.CONNECT_TIMEOUT){
          return APIResponse<String>(data: "500", errorMessage: "Connection Timeout", error: true);
        }
        // internet is not open
        if(e.type== DioErrorType.DEFAULT){
          return APIResponse<String>(data: "101", errorMessage: "Internet is not avaible.", error: true);
        }
        print(e.request);
        print(e.message);
        return null;
      }
    }
  }

  Future<int> initUser() async {
    try {
      Response response = await _dio.get("user/get");
      _user = new User.fromJson(response.data);
      return response.statusCode;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
        return e.response.statusCode;
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.request);
        print(e.message);
        return null;
      }
    }
  }

  Future<int> addUserAddress(Address address) async {
    try {
      Response response = await _dio.post("user/addAddress",
          data: json.encode(address.toJson()));
      print(response);
      return response.statusCode;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.statusCode);
        return e.response.statusCode;
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.request);
        print(e.message);
        return null;
      }
    }
  }
   Future<int> updateAddress(Address address) async {
    try {
      Response response = await _dio.post("user/updateAddress",
          data: json.encode(address.toUpdateJson()));
      print(response);
      return response.statusCode;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.statusCode);
        return e.response.statusCode;
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.request);
        print(e.message);
        return null;
      }
    }
  }

  Future<List<Address>> getUserAddresses() async {
    try {
      Response response = await _dio.get(
        "user/getadress",
      );
      List<Address> result=new List();
      print(response);
       if (response.data.length != 0) {
          List<dynamic> i = response.data;
          result = i.map((p) => Address.fromJson(p)).toList();
          result.sort((a,b)=>a.addressID.compareTo(b.addressID));
          return result;
        }
        return null;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.statusCode);
        return null;
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.request);
        print(e.message);
        return null;
      }
    }
  }

  Future<int> deleteAddress(int addressID) async {
    try {
      Response response = await _dio.delete(
        "user/deleteAddress",
        queryParameters: {
          "addressID":addressID
        }
      );
      print("${response.statusCode}");
        return response.statusCode;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.statusCode);
        return e.response.statusCode;
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.request);
        print(e.message);
        return 500;
      }
    }
  }

    Future<int> addSellerAddress(Address address) async {
    try {
      Response response = await _dio.post("user/addSellerAddress",
          data: json.encode(address.toJson()));
      
      print(response);
      return response.statusCode;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.statusCode);
        return e.response.statusCode;
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.request);
        print(e.message);
        return null;
      }
    }
  }
  Future<int> updateUser(User user) async {
    try {
      Response response = await _dio.post("user/update",
          data: json.encode(user.toJsonUpdate()));
      print(response);
      return response.statusCode;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.statusCode);
        return e.response.statusCode;
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.request);
        print(e.message);
        return null;
      }
    }
  }
  Future<int> becameSeller(User user) async {
    try {
      Response response = await _dio.post("user/update",
          data: json.encode(user.toJsonBecameSeller()));
      print(response);
      return response.statusCode;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.statusCode);
        return e.response.statusCode;
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.request);
        print(e.message);
        return null;
      }
    }
  }
  User getUser() {
    return _user;
  }
}
