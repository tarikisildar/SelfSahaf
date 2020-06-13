import 'package:dio/dio.dart';
import 'package:Selfsahaf/controller/generalServices.dart';
import 'package:Selfsahaf/models/api_response.dart';

class AdminService extends GeneralServices {
  Dio _dio;
  AdminService() {
    this._dio = super.dio;
  }

  Future<APIResponse<int>> getOrderCount() async {
    try {
      Response response = await _dio.get("admin/getOrderCount");
      print(response.data);
      if (response.statusCode == 200)
        return APIResponse<int>(data: int.parse(response.data.toString()));
      else
        return APIResponse<int>(
            data: 0, error: true, errorMessage: response.data.toString());
    } on DioError catch (e) {
      return APIResponse<int>(
          data: 0, error: true, errorMessage: "Some errors Occurs");
    }
  }
  Future<APIResponse<int>> getSellerCount() async {
    try {
      Response response = await _dio.get("admin/getSellerCount");
      if (response.statusCode == 200)
        return APIResponse<int>(data: int.parse(response.data.toString()));
      else
        return APIResponse<int>(
            data: 0, error: true, errorMessage: response.data.toString());
    } on DioError catch (e) {
      return APIResponse<int>(
          data: 0, error: true, errorMessage: "Some errors Occurs");
    }
  }
  Future<APIResponse<int>> getUserCount() async {
    try {
      Response response = await _dio.get("admin/getUserCount");
      if (response.statusCode == 200)
        return APIResponse<int>(data: int.parse(response.data.toString()));
      else
        return APIResponse<int>(
            data: 0, error: true, errorMessage: response.data.toString());
    } on DioError catch (e) {
      return APIResponse<int>(
          data: 0, error: true, errorMessage: "Some errors Occurs");
    }
  }
}
