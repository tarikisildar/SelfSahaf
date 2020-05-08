import 'package:dio/dio.dart';
import 'package:selfsahaf/models/user.dart';
import 'package:selfsahaf/models/api_response.dart';

import 'package:selfsahaf/controller/generalServices.dart';

class AuthService extends GeneralServices {
  Dio _dio;
  User _user;
  AuthService(){
  _dio= super.dio;
  }
  Future<int> loginWithEmail(String email, String password) async {
    try {
      Response response = await _dio.post(
        "login?email=" + email + "&password=" + password,
      );
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

  Future<String> signup(data) async {
    try {
      Response response = await _dio.post("user/add", data: data);

      return response.data.toString();
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
        return e.response.statusMessage;
      } else {
        print(e.request);
        print(e.message);
        return null;
      }
    }
  }

  Future<int> initUser() async {
    try {
      Response response = await _dio.get("user/get");
      _user=new User.fromJson(response.data);
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
 User getUser(){
   return _user;
 }
  
}
