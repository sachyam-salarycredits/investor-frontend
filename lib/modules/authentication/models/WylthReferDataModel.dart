class WylthReferDataModel {
  WylthReferDataModel({
    required this.id,
    required this.userName,
    required this.flyyUrl,
    required this.referCode,
    required this.customerId,
  });

  int id;
  String userName;
  String flyyUrl;
  String referCode;
  String customerId;

  factory WylthReferDataModel.fromJson(Map<String, dynamic> json) => WylthReferDataModel(
    id: json["id"],
    userName: json["userName"],
    flyyUrl: json["flyyUrl"],
    referCode: json["referCode"],
    customerId: json["customerId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userName": userName,
    "flyyUrl": flyyUrl,
    "referCode": referCode,
    "customerId": customerId,
  };
}