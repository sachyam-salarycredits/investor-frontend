class AuthorizedSignatory {
  String? customerId;
  String? authorizedSignatoryName;
  int? date;
  String? aadharNumber;
  String? fileUrl;

  AuthorizedSignatory({
    this.customerId,
    this.authorizedSignatoryName,
    this.date,
    this.aadharNumber,
    this.fileUrl,
  });

  AuthorizedSignatory.fromJson(Map<String, dynamic> json) {
    customerId = json['customerId'] == null ? null : json['customerId'];
    authorizedSignatoryName = json['authorizedSignatoryName'] == null
        ? null
        : json['authorizedSignatoryName'];
    aadharNumber = json['aadharNumber'] == null ? null : json['aadharNumber'];
    fileUrl = json['fileUrl'] == null ? null : json['fileUrl'];
    date = json['date'] == null ? null : json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerId'] = this.customerId;
    data['authorizedSignatoryName'] = this.authorizedSignatoryName;
    data['date'] = this.date;
    data['aadharNumber'] = this.aadharNumber;
    data['fileUrl'] = this.fileUrl;
    return data;
  }
}
