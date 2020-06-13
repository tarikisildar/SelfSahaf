import 'dart:convert';
import 'package:Selfsahaf/models/given_orders.dart';
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
      int addressID, int shippingCompanyID, CardModel card) async {
    try {
      Response response = await _dio.post("order/confirmOrder",
          queryParameters: {
            "addressID": addressID,
            "shippingCompanyID": shippingCompanyID
          },
          data: json.encode(card.toJson()));
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
        } else {
          return APIResponse<List<Order>>(data: null);
        }
      }

      return APIResponse<List<Order>>(
          data: null, error: true, errorMessage: "Some error occurs");
    } on DioError catch (e) {
      return APIResponse<List<Order>>(
          data: null, error: true, errorMessage: "Some error occurs");
    }
  }

  Future<APIResponse<int>> markOrder(
      int orderID, int productID, String status) async {
    try {
      Response response = await _dio.post("order/markOrder", queryParameters: {
        "orderID": orderID,
        "productID": productID,
        "status": status
      });
      if (response.statusCode == 200) {
        return APIResponse<int>(data: response.statusCode);
      } else if (response.statusCode == 403) {
        return APIResponse<int>(
            data: 403, error: true, errorMessage: response.data.toString());
      }
      return APIResponse<int>(
          data: -1, error: true, errorMessage: "Some error occurs");
    } on DioError catch (e) {
      return APIResponse<int>(
          data: -1, error: true, errorMessage: "Some error occurs");
    }
  }
  Future<APIResponse<List<GivenOrders>>> givenOrders() async {
    try {
      Response response = await _dio.get("order/givenOrders");
      List<GivenOrders> result;
      if (response.statusCode == 200) {
        if (response.data.length != 0) {
          List<dynamic> i = response.data;
          result = i.map((p) => GivenOrders.fromJson(p)).toList();
          return APIResponse<List<GivenOrders>>(data: result);
        } else {
          return APIResponse<List<GivenOrders>>(data: null);
        }
      }
      return APIResponse<List<GivenOrders>>(
          data: null, error: true, errorMessage: "Some error occurs");
    } on DioError catch (e) {
      return APIResponse<List<GivenOrders>>(
          data: null, error: true, errorMessage: "Some error occurs");
    }
  }
   Future<APIResponse<List<Order>>> givenOrderDetails(int orderID) async {
    try {
      Response response = await _dio.get("order/getOrderDetails",queryParameters: {
        "orderID":orderID
      });
      List<Order> result;
      if (response.statusCode == 200) {
        print(response.data);
        if (response.data.length != 0) {
          List<dynamic> i = response.data;
          result = i.map((p) => Order.fromJson(p)).toList();
          return APIResponse<List<Order>>(data: result);
        } else {
          return APIResponse<List<Order>>(data: null);
        }
      }
      return APIResponse<List<Order>>(
          data: null, error: true, errorMessage: "Some error occurs");
    } on DioError catch (e) {
      return APIResponse<List<Order>>(
          data: null, error: true, errorMessage: "Some error occurs");
    }
  }
}
