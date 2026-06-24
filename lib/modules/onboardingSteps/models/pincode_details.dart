class PinCodeDetail {
  String? officename;
  String? pincode;
  String? officetype;
  String? deliverystatus;
  String? divisionname;
  String? regionname;
  String? circlename;
  String? taluk;
  String? districtname;
  String? statename;
  String? telephone;
  String? relatedSuboffice;
  String? relatedHeadoffice;

  PinCodeDetail(
      {this.officename,
      this.pincode,
      this.officetype,
      this.deliverystatus,
      this.divisionname,
      this.regionname,
      this.circlename,
      this.taluk,
      this.districtname,
      this.statename,
      this.telephone,
      this.relatedSuboffice,
      this.relatedHeadoffice});

  PinCodeDetail.fromJson(Map<String, dynamic> json) {
    officename = json['officename'] == null ? null : json['officename'];
    pincode = json['pincode'] == null ? null : json['pincode'];
    officetype = json['officetype'] == null ? null : json['officetype'];
    deliverystatus =
        json['deliverystatus'] == null ? null : json['deliverystatus'];
    divisionname = json['divisionname'] == null ? null : json['divisionname'];
    regionname = json['regionname'] == null ? null : json['regionname'];
    circlename = json['circlename'] == null ? null : json['circlename'];
    taluk = json['taluk'] == null ? null : json['taluk'];
    districtname = json['districtname'] == null ? null : json['districtname'];
    statename = json['statename'] == null ? null : json['statename'];
    telephone = json['telephone'] == null ? null : json['telephone'];
    relatedSuboffice =
        json['related_suboffice'] == null ? null : json['related_suboffice'];
    relatedHeadoffice =
        json['related_headoffice'] == null ? null : json['related_headoffice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['officename'] = this.officename;
    data['pincode'] = this.pincode;
    data['officetype'] = this.officetype;
    data['deliverystatus'] = this.deliverystatus;
    data['divisionname'] = this.divisionname;
    data['regionname'] = this.regionname;
    data['circlename'] = this.circlename;
    data['taluk'] = this.taluk;
    data['districtname'] = this.districtname;
    data['statename'] = this.statename;
    data['telephone'] = this.telephone;
    data['related_suboffice'] = this.relatedSuboffice;
    data['related_headoffice'] = this.relatedHeadoffice;
    return data;
  }
}
