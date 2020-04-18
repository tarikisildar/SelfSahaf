import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:selfsahaf/models/api_response.dart';
import 'package:selfsahaf/models/book.dart';

class ProductService {
  static const API = 'http://142.93.106.79:8080/accessing-data-mysql/';
  final Dio _dio = Dio()
    ..options.connectTimeout = 5000
    ..options.receiveTimeout = 3000;
  Response response;
  APIResponse<int> apiresponse;

  Future<APIResponse<int>> addBook(Book book, int sellerID) async {
    try {
      return await _dio
          .post(API+
              "product/addBook",
                  queryParameters:{
                    "price":book.price,
                    "quantity":book.quantity,
                    "sellerID":sellerID
                  } ,
              data: json.encode(book.toJsonBook()) )
          .then((r) {
        if (r.statusCode == 200) {
       return apiresponse=APIResponse<int>(data: r.statusCode);
        }
        return apiresponse=APIResponse<int>(data: r.statusCode,error: true,eroorMessage: "selamın aleykum");
      });
   
    } on DioError catch (e) {
      print(e.response.statusCode);
    }
  }
}
