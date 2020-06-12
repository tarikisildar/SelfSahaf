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
}