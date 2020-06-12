import 'dart:convert';
import 'package:Selfsahaf/models/order.dart';
import 'package:Selfsahaf/models/rating.dart';
import 'package:dio/dio.dart';
import 'package:Selfsahaf/controller/generalServices.dart';
import 'package:Selfsahaf/models/api_response.dart';
import 'package:Selfsahaf/models/card_model.dart';

class RatingService extends GeneralServices {
  Dio _dio;
  RatingService() {
    this._dio = super.dio;
  }

  Future<APIResponse<List<Rating>>> getRatings(int sellerID) async {
    try {
      Response response = await _dio.get(
        "rating/getRatings",
      );
      List<Rating> result = new List();
      print(response);

      if (response.statusCode == 200) {
        if (response.data.length != 0) {
          List<dynamic> i = response.data;
          result = i.map((p) => Rating.fromJson(p)).toList();
          return APIResponse<List<Rating>>(data: result, error: false);
        } else
          return APIResponse<List<Rating>>(data: null, error: false);
      } else if (response.statusCode == 403)
        return APIResponse<List<Rating>>(
            data: null, error: true, errorMessage: "Something went wrong!");
      else
        return APIResponse<List<Rating>>(
            data: null, error: true, errorMessage: "Some errors occurs.!");
    } on DioError catch (e) {
      return APIResponse<List<Rating>>(
          data: null, error: true, errorMessage: "Some errors occurs!");
    }
  }
}
