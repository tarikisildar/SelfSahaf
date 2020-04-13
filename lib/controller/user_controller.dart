
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


class AuthService {
  final Dio _dio = Dio()
    ..options.baseUrl = 'http://142.93.106.79:8080/accessing-data-mysql/user/'
    ..options.connectTimeout = 5000
    ..options.receiveTimeout = 3000;

  Future<int> loginWithEmail(String email, String password) async {
    try {
      Response response =
          await _dio.post("login/?email=" + email + "&password=" + password);
          
      //_token = response.data["token"];
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
}
