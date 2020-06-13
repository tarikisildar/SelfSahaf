import 'dart:convert';
import 'package:Selfsahaf/models/order.dart';
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
  Future<APIResponse<List<Order>>> getTakenOrders() async {
    try {
      Response response = await _dio.get("order/takenOrders");
      List<Order> result;
      if (response.statusCode == 200) {
        if (response.data.length != 0) {
            
          List<dynamic> i = response.data;
          result = i.map((p) => Order.fromJson(p)).toList();
          return APIResponse<List<Order>>(data: result);
        }
        else{
      
         return APIResponse<List<Order>>(data: null);
         }
      }

      //_token = response.data["token"];
   
      return APIResponse<List<Order>>(data: null, error: true, errorMessage: "Some error occurs");
    } on DioError catch (e) {

     return APIResponse<List<Order>>(data: null, error: true, errorMessage: "Some error occurs");
    }
  }
}
