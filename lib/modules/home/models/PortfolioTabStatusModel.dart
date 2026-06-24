// To parse this JSON data, do
//
//     final portfolioTabStatusModel = portfolioTabStatusModelFromJson(jsonString);

import 'dart:convert';

PortfolioTabStatusModel portfolioTabStatusModelFromJson(String str) =>
    PortfolioTabStatusModel.fromJson(json.decode(str));

String portfolioTabStatusModelToJson(PortfolioTabStatusModel data) =>
    json.encode(data.toJson());

class PortfolioTabStatusModel {
  PortfolioTabStatusModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  String statusCode;
  String message;
  List<Datum> data;

  factory PortfolioTabStatusModel.fromJson(Map<String, dynamic> json) =>
      PortfolioTabStatusModel(
        statusCode: json["statusCode"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.tabId,
    this.name,
    this.status,
  });

  int? id;
  String? tabId;
  String? name;
  bool? status;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        tabId: json["tabId"],
        name: json["name"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tabId": tabId,
        "name": name,
        "status": status,
      };
}
