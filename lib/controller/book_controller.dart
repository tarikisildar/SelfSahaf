import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:selfsahaf/models/book.dart';


class AuthService {
  final Dio _dio = Dio()
    ..options.baseUrl = 'http://142.93.106.79:8080/accessing-data-mysql/product/'
    ..options.connectTimeout = 5000
    ..options.receiveTimeout = 3000;

    Future<List<Book>> getBooks(String email, String password) async {
    try {
      Response response =
          await _dio.get("getBooks");
          List<Book> result;
        if (response.statusCode == 200) {
          List<dynamic> i = response.data;
          result = i.map((p) => Book.fromJson(p)).toList();
          return result;
        }
          
      //_token = response.data["token"];
      result = [null];
      return result;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
        return [null];
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.request);
        print(e.message);
        return [null];
      }
    }
  }

}


