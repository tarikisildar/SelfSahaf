import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:Selfsahaf/controller/generalServices.dart';
import 'package:Selfsahaf/models/api_response.dart';
import 'package:Selfsahaf/models/card_model.dart';
class OrderService extends GeneralServices {
  Dio _dio;
  OrderService() {
    this._dio = super.dio;
  }
    Future<APIResponse<int>> confirmOrder(
      int addressID, int shippingCompanyID,CardModel card ) async {
    try {
      Response response = await _dio.post("order/confirmOrder",queryParameters: {
        "addressID":addressID,
        "shippingCompanyID":shippingCompanyID
      }, data:json.encode(card.toJson()));
      print(response.data);
      if (response.statusCode == 200)
        return APIResponse<int>(data: response.statusCode);
      else if (response.statusCode == 403)
        return APIResponse<int>(
            data: response.statusCode,
            error: true,
            errorMessage: response.data.toString());
      else
        return APIResponse<int>(
            data: response.statusCode,
            error: true,
            errorMessage: "Some errors occurs.");
    } on DioError catch (e) {
      return APIResponse(
          data: -1, error: true, errorMessage: "Some errors occurs.");
    }
  }
}
