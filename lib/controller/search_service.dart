import 'package:Selfsahaf/controller/generalServices.dart';
import 'package:Selfsahaf/models/api_response.dart';
import 'package:dio/dio.dart';
import 'package:Selfsahaf/models/book.dart';

class SearchService extends GeneralServices {
  Dio _dio;
  SearchService() {
    this._dio = super.dio;
  }
  Future<APIResponse<List<Book>>> searchBooksByName(
      String name, int pageNo, int pageSize) async {
    try {
      Response response = await _dio.get("", queryParameters: {
        "name": name,
        "pageNo": pageNo,
        "pageSize": pageSize
      });
      print(response);
      if (response.statusCode == 200) {
        if(response.data.toString()=="<h1>Hello Spring Boot Security</h1>"){
           return APIResponse(
          data: null, error: true, errorMessage: "you need to login to search.");
        }
        List<Book> result;
        List<dynamic> i = response.data;
        result = i.map((p) => Book.fromJson(p)).toList();
        return APIResponse(data: result);
      }
      return APIResponse(
          data: null, error: true, errorMessage: "Some errors occurs.");
    } on DioError catch (e) {
      return APIResponse(
          data: null, error: true, errorMessage: "Some errors occurs.");
    }
  }
}
