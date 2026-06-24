class BankDetail {
  String? ifscCode;
  String? bankName;
  String? branch;
  String? address;
  String? city1;
  String? city2;
  String? state;
  String? stdCode;
  String? phone;

  BankDetail(
      {this.ifscCode,
      this.bankName,
      this.branch,
      this.address,
      this.city1,
      this.city2,
      this.state,
      this.stdCode,
      this.phone});

  BankDetail.fromJson(Map<String, dynamic> json) {
    ifscCode = json['ifscCode'] == null ? null : json['ifscCode'];
    bankName = json['bankName'] == null ? null : json['bankName'];
    branch = json['branch'] == null ? null : json['branch'];
    address = json['address'] == null ? null : json['address'];
    city1 = json['city1'] == null ? null : json['city1'];
    city2 = json['city2'] == null ? null : json['city2'];
    state = json['state'] == null ? null : json['state'];
    stdCode = json['stdCode'] == null ? null : json['stdCode'];
    phone = json['phone'] == null ? null : json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ifscCode'] = this.ifscCode;
    data['bankName'] = this.bankName;
    data['branch'] = this.branch;
    data['address'] = this.address;
    data['city1'] = this.city1;
    data['city2'] = this.city2;
    data['state'] = this.state;
    data['stdCode'] = this.stdCode;
    data['phone'] = this.phone;
    return data;
  }
}
