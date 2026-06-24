class BankDetailSipModel {
  BankDetailSipModel({
    this.data,
    this.sfLogs,
  });

  BankDetailSipModel.fromJson(dynamic json) {
    data = json['data'] != null ? BankDetailModel.fromJson(json['data']) : null;
    sfLogs = json['sfLogs'];
  }
  BankDetailModel? data;
  dynamic? sfLogs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['sfLogs'] = sfLogs;
    return map;
  }
}

class BankDetailModel {
  BankDetailModel({
    this.object,
    this.livemode,
    this.id,
    this.displayName,
    this.name,
    this.ifsc,
    this.achDr,
    this.variantEsign,
    this.variantApi,
    this.variantApiDebitcard,
    this.variantApiNetbanking,
    this.variantApiAadhaar,
  });

  BankDetailModel.fromJson(dynamic json) {
    object = json['object'];
    livemode = json['livemode'];
    id = json['id'];
    displayName = json['display_name'];
    name = json['name'];
    ifsc = json['ifsc'];
    achDr = json['ach_dr'];
    variantEsign = json['variant_esign'];
    variantApi = json['variant_api'];
    variantApiDebitcard = json['variant_api_debitcard'];
    variantApiNetbanking = json['variant_api_netbanking'];
    variantApiAadhaar = json['variant_api_aadhaar'];
  }
  String? object;
  bool? livemode;
  String? id;
  String? displayName;
  String? name;
  String? ifsc;
  bool? achDr;
  bool? variantEsign;
  bool? variantApi;
  bool? variantApiDebitcard;
  bool? variantApiNetbanking;
  bool? variantApiAadhaar;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['object'] = object;
    map['livemode'] = livemode;
    map['id'] = id;
    map['display_name'] = displayName;
    map['name'] = name;
    map['ifsc'] = ifsc;
    map['ach_dr'] = achDr;
    map['variant_esign'] = variantEsign;
    map['variant_api'] = variantApi;
    map['variant_api_debitcard'] = variantApiDebitcard;
    map['variant_api_netbanking'] = variantApiNetbanking;
    map['variant_api_aadhaar'] = variantApiAadhaar;
    return map;
  }
}
