class CashFreeDetail {
  int? orderId;
  String? cftoken;
  String? orderToken;
  String? bankCode;

  CashFreeDetail({this.orderId, this.cftoken, this.bankCode});

  CashFreeDetail.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'] == null ? null : json['orderId'];
    cftoken = json['cftoken'] == null ? null : json['cftoken'];
    orderToken = json['orderToken'] == null ? null : json['orderToken'];
    bankCode = json['bankCode'] == null ? null : json['bankCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['cftoken'] = this.cftoken;
    data['orderToken'] = this.orderToken;
    data['bankCode'] = this.bankCode;
    return data;
  }
}
