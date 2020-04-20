import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:selfsahaf/controller/generalServices.dart';
import 'package:selfsahaf/models/api_response.dart';
import 'package:selfsahaf/models/book.dart';

class ProductService extends GeneralServices {
Dio _dio;
  Response response;
  APIResponse<int> apiresponse;
   ProductService(){
     this._dio=super.dio;
  }

  Future<APIResponse<int>> addBook(Book book, int sellerID) async {
    try {
      return await _dio
          .post(
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
