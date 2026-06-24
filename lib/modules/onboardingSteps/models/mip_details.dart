class MipDetails {
  int? id;
  String? optionName;
  bool? certificate80gAvailable;
  String? artUrl;
  List<MipPartner>? partnerList;


  MipDetails({
    this.id,
    this.optionName,
    this.certificate80gAvailable,
    this.artUrl,
    this.partnerList,
  });

  MipDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    optionName = json['optionName'];
    certificate80gAvailable = json['certificate80gAvailable'];
    artUrl = json['artUrl'];
    if (json['partnerList'] != null) {
      partnerList = <MipPartner>[];
      json['partnerList'].forEach((v) {
        partnerList?.add(new MipPartner.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['optionName'] = this.optionName;
    data['certificate80gAvailable'] = this.certificate80gAvailable;
    data['artUrl'] = this.artUrl;
    data['partnerList'] = this.partnerList;
    return data;
  }
}

class MipPartner {
  String? mipPartnerId;
  String? partnerName;
  String? causeName;
  bool? is80GCertificateEnabled;
  String? cardArtUrl;

  MipPartner({
    this.mipPartnerId,
    this.partnerName,
    this.causeName,
    this.is80GCertificateEnabled,
    this.cardArtUrl,
  });

  MipPartner.fromJson(Map<String, dynamic> json) {
    mipPartnerId = json['mipPartnerId'] == null ? null : json['mipPartnerId'];
    partnerName = json['partnerName'] == null ? null : json['partnerName'];
    causeName = json['causeName'] == null ? null : json['causeName'];
    is80GCertificateEnabled = json['is80GCertificateEnabled'] == null
        ? false
        : json['is80GCertificateEnabled'];
    cardArtUrl = json['cardArtUrl'] == null ? null : json['cardArtUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mipPartnerId'] = this.mipPartnerId;
    data['partnerName'] = this.partnerName;
    data['causeName'] = this.causeName;
    data['is80GCertificateEnabled'] = this.is80GCertificateEnabled;
    data['cardArtUrl'] = this.cardArtUrl;
    return data;
  }
}

class OldMipDetail {
  String? mipPartnerId;
  int? mipOptionId;
  bool enable;

  OldMipDetail({
    this.mipPartnerId,
    this.mipOptionId,
    this.enable = true,
  });

  factory OldMipDetail.fromJson(Map<String, dynamic> json) {
    return OldMipDetail(
      mipPartnerId: json['mipPartnerId'] == null ? null : json['mipPartnerId'],
      mipOptionId: json['mipOptionId'] == null ? null : json['mipOptionId'],
      enable: json['enable'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mipPartnerId'] = this.mipPartnerId;
    data['mipOptionId'] = this.mipOptionId;
    data['enable'] = this.enable;
    return data;
  }
}
