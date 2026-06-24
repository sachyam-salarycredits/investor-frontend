// To parse this JSON data, do
//
//     final redemptionData = redemptionDataFromJson(jsonString);

import 'dart:convert';

RedemptionData redemptionDataFromJson(String str) =>
    RedemptionData.fromJson(json.decode(str));

String redemptionDataToJson(RedemptionData data) => json.encode(data.toJson());

class RedemptionData {
  RedemptionData({
    this.loanList = const [],
  });

  List<LoanList> loanList;

  factory RedemptionData.fromJson(Map<String, dynamic> json) => RedemptionData(
        loanList: json["loanList"] == null
            ? []
            : List<LoanList>.from(
                json["loanList"].map((x) => LoanList.fromJson(x)))
          ..sort((a, b) => -(a.dDate!.compareTo(b.dDate!))),
      );

  Map<String, dynamic> toJson() => {
        "loanList": List<dynamic>.from(loanList.map((x) => x.toJson())),
      };

  //old to new
  List<LoanList> sortList(List<LoanList> loans) {
    loans.sort((a, b) => (a.dDate!.compareTo(b.dDate!)));
    return loans;
  }
}

class LoanList {
  LoanList({
    this.totalAmount = 0,
    this.dDate,
    this.contractId = "",
    this.customerId = "",
    this.ip = "",
  });

  int totalAmount;
  DateTime? dDate;
  String contractId;
  String customerId;
  String ip;

  factory LoanList.fromJson(Map<String, dynamic> json) => LoanList(
        totalAmount:
            json["totalAmount"] == null ? 0 : json["totalAmount"].toInt(),
        dDate: json["d_Date"] == null
            ? DateTime.now()
            : DateTime.parse(json['d_Date']),
        contractId: json["contractId"] == null ? "" : json["contractId"],
        customerId: json["customerId"] == null ? "" : json["customerId"],
      );

  Map<String, dynamic> toJson() => {
        "totalAmount": totalAmount,
        "ip": ip,
        "d_Date": "${dDate!.year}-${dDate!.month}-${dDate!.day}",
        "contractId": contractId,
        "customerId": customerId,
      };
}
