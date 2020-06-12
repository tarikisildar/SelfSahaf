import 'package:Selfsahaf/models/book.dart';
import 'package:Selfsahaf/models/user.dart';

class Order {
  int orderDetailID;
  int quantity;
  String status;
  User buyer;
  User seller;
  String price;
  Book product;
  Order({
    this.orderDetailID,
    this.quantity,
    this.status,
    this.buyer,
    this.seller,
    this.product
  });

  Map<String, dynamic> toJsonBookUpdate() {
    return {
      "orderDetailID": orderDetailID,
      "product": product,
      "quantity": quantity,
      "status": status,
      "buyer": buyer,
      "seller": seller,
    };
  }

  Order.fromJson(Map<String, dynamic> json)
      : orderDetailID = json["orderDetailID"],
        quantity = json["quantity"],
        status = json["status"],
        buyer = User.fromJson(json["buyer"]),
        seller = User.fromJson(json["seller"]),
        price = json["sells"][0]['price'];

  

}
