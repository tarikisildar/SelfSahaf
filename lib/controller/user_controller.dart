
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:selfsahaf/models/user.dart';
import 'package:selfsahaf/models/api_response.dart';

class AuthService {
  final Dio _dio = Dio()
    ..options.baseUrl = 'http://165.22.19.197:8080/accessing-data-mysql/'
    ..options.connectTimeout = 5000
    ..options.receiveTimeout = 3000;

    

  Future<Response> loginWithEmail(String email, String password) async {
    try {
      print(email);
      print(password);
      Response response =
          await _dio.post("login?email=" + email + "&password=" + password,  options: Options(
        followRedirects: true,
        validateStatus: (status) { return status < 500;},
    ),);
          
      //_token = response.data["token"];

      print(response.headers["set-cookie"].toString().split(';')[0].split('=')[1]);
       print(response.statusCode);
      return response;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.statusCode );
        return e.response;
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.request);
        print(e.message);
        return null;
      }
    }
  }

  Future<int> signup(data) async {
    try {
      Response response = await _dio.post("login/?email", data: data);

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
