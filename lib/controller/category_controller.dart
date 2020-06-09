
import 'package:dio/dio.dart';
import 'package:Selfsahaf/controller/generalServices.dart';

class CategoryService extends GeneralServices{
  Dio _dio;
  CategoryService(){
  _dio= super.dio;
  }
  Future<int> addCategory(String categoryName) async {
    try {
      Response response = await _dio.post("product/addCategory?name=$categoryName");
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
}