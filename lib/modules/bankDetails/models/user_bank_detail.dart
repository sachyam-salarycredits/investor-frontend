class UserBankDetail {
  String? acountNumber;
  String? fullName;
  String? ifscCode;
  String? bankName;
  String? branchnName;

  UserBankDetail({
    this.acountNumber,
    this.fullName,
    this.ifscCode,
    this.bankName,
    this.branchnName,
  });

  UserBankDetail.fromJson(Map<String, dynamic> json) {
    acountNumber = json['acountNumber'] == null ? null : json['acountNumber'];
    fullName = json['fullName'] == null ? null : json['fullName'];
    ifscCode = json['ifscCode'] == null ? null : json['ifscCode'];
    bankName = json['bankName'] == null ? null : json['bankName'];
    branchnName = json['branchnName'] == null ? null : json['branchnName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['acountNumber'] = this.acountNumber;
    data['fullName'] = this.fullName;
    data['ifscCode'] = this.ifscCode;
    data['bankName'] = this.bankName;
    data['branchnName'] = this.branchnName;
    return data;
  }
}
