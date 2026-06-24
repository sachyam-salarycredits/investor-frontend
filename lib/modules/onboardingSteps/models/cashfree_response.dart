// To parse this JSON data, do
//
//     final cashFreeResponse = cashFreeResponseFromJson(jsonString);

import 'dart:convert';

CashFreeResponse cashFreeResponseFromJson(String str) => CashFreeResponse.fromJson(json.decode(str));

String cashFreeResponseToJson(CashFreeResponse data) => json.encode(data.toJson());

class CashFreeResponse {
  CashFreeResponse({
    this.paymentMethod,
    this.channel,
    this.action,
    this.data,
    this.cfPaymentId,
  });

  String? orderId;
  String? paymentMethod;
  String? channel;
  String? action;
  Data? data;
  int? cfPaymentId;

  factory CashFreeResponse.fromJson(Map<String, dynamic> json) => CashFreeResponse(
    paymentMethod: json["payment_method"],
    channel: json["channel"],
    action: json["action"],
    data: json["data"]==null?null:Data.fromJson(json["data"]),
    cfPaymentId: json["cf_payment_id"],
  );

  Map<String, dynamic> toJson() => {
    "payment_method": paymentMethod,
    "channel": channel,
    "action": action,
    "data": data==null?null:data!.toJson(),
    "cf_payment_id": cfPaymentId,
  };
}

class Data {
  Data({
    this.url="",
    this.payload,
    this.contentType,
    this.method,
  });

  String url;
 dynamic payload;
  dynamic contentType;
  dynamic method;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    url: json["url"]??"",
    payload: json["payload"]==null?{}:json["payload"],
    contentType: json["content_type"],
    method: json["method"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "payload": payload,
    "content_type": contentType,
    "method": method,
  };
}
