class PersonalDetail {
  String? fullName;
  String? email;
  String? mobileNo;
  String? aadharNo;

  PersonalDetail({
    this.fullName,
    this.email,
    this.mobileNo,
    this.aadharNo,
  });

  PersonalDetail.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'] == null ? null : json['fullName'];
    aadharNo = json['aadharNo'] == null ? null : json['aadharNo'];
    email = json['email'] == null ? null : json['email'];
    mobileNo = json['mobileNo'] == null ? null : json['mobileNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['mobileNo'] = this.mobileNo;
    data['aadharNo'] = this.aadharNo;
    return data;
  }
}
