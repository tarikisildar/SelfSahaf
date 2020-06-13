

class RefundModel {
 int refundID;
 String dateTime;
 String status;
 String message;
  RefundModel({
    this.dateTime,
    this.message,
    this.refundID,
    this.status
  });

  Map<String, dynamic> toJson() {
    return {
      "refundID": refundID,
      "datetime": dateTime,
      "status": status,
      "message": message,

    };
  }

  RefundModel.fromJson(Map<String, dynamic> json)
      : refundID = json["refundID"],
      dateTime = json["datetime"],
      status = json["status"],
      message = json["message"]
        ;

  

}
