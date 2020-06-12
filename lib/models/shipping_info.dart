import 'package:Selfsahaf/models/shipping_company_model.dart';

class ShippingInfo{
  String shippingInfoID;
  String trackingNumber;
  ShippingCompanyModel shippingcompany;
  ShippingInfo({
    this.shippingInfoID,
    this.trackingNumber,
    this.shippingcompany,
  });
   ShippingInfo.fromJson(Map<String, dynamic> json)
      : shippingInfoID=json["shippingInfoID"],
      trackingNumber=json["trackingNumber"],
      shippingcompany=ShippingCompanyModel.fromJson( json["shippingCompanyID"])
      ;
}