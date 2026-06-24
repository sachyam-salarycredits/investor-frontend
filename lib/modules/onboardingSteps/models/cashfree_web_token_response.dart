// To parse this JSON data, do
//
//     final cashFreeOrderResponse = cashFreeOrderResponseFromJson(jsonString);

import 'dart:convert';

CashFreeOrderResponse cashFreeOrderResponseFromJson(String str) =>
    CashFreeOrderResponse.fromJson(json.decode(str));

String cashFreeOrderResponseToJson(CashFreeOrderResponse data) =>
    json.encode(data.toJson());

class CashFreeOrderResponse {
  CashFreeOrderResponse(
      {this.orderId,
      this.orderAmount,
      this.orderCurrency,
      this.customerId,
      this.paymentMode,
      this.orderStatus,
      this.createDate,
      this.updateDate,
      this.paymentLink,
      this.orderToken,
      this.txMsg,
      this.bankCode});

  String? txMsg;
  String? bankCode;
  String? orderId;
  double? orderAmount;
  String? orderCurrency;
  String? customerId;
  String? paymentMode;
  String? orderStatus;
  String? createDate;
  String? updateDate;
  String? paymentLink;
  String? orderToken;

  factory CashFreeOrderResponse.fromJson(Map<String, dynamic> json) =>
      CashFreeOrderResponse(
        orderId: json["orderId"] == null ? null : json["orderId"],
        txMsg: json["txMsg"] == null ? null : json["txMsg"],
        bankCode: json["bankCode"] == null ? null : json["bankCode"],
        orderAmount:
            json["orderAmount"] == null ? null : json["orderAmount"].toDouble(),
        orderCurrency:
            json["orderCurrency"] == null ? null : json["orderCurrency"],
        customerId: json["customerId"] == null ? null : json["customerId"],
        paymentMode: json["paymentMode"] == null ? null : json["paymentMode"],
        orderStatus: json["orderStatus"] == null ? null : json["orderStatus"],
        createDate: json["createDate"] == null ? null : json["createDate"],
        updateDate: json["updateDate"] == null ? null : json["updateDate"],
        paymentLink: json["paymentLink"] == null ? null : json["paymentLink"],
        orderToken: json["orderToken"] == null ? null : json["orderToken"],
      );

  Map<String, dynamic> toJson() => {
        "orderId": orderId == null ? null : orderId,
        "txMsg": txMsg == null ? null : txMsg,
        "bankCode": bankCode == null ? null : bankCode,
        "orderAmount": orderAmount == null ? null : orderAmount,
        "orderCurrency": orderCurrency == null ? null : orderCurrency,
        "customerId": customerId == null ? null : customerId,
        "paymentMode": paymentMode,
        "orderStatus": orderStatus == null ? null : orderStatus,
        "createDate": createDate == null ? null : createDate,
        "updateDate": updateDate == null ? null : updateDate,
        "paymentLink": paymentLink,
        "orderToken": orderToken,
      };
}
