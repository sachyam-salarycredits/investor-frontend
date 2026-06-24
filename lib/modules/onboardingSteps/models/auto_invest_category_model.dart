
// class AutoInvestCategoryModel {
//   AutoInvestCategoryModel({
//     String? statusCode,
//     dynamic message,
//     List<Data>? data,
//     dynamic sfLogs,
//   }) {
//     _statusCode = statusCode;
//     _message = message;
//     _data = data;
//     _sfLogs = sfLogs;
//   }
//
//   AutoInvestCategoryModel.fromJson(dynamic json) {
//     _statusCode = json['statusCode'];
//     _message = json['message'];
//     if (json['data'] != null) {
//       _data = [];
//       json['data'].forEach((v) {
//         _data?.add(Data.fromJson(v));
//       });
//     }
//     _sfLogs = json['sfLogs'];
//   }
//   String? _statusCode;
//   dynamic _message;
//   List<Data>? _data;
//   dynamic _sfLogs;
//   AutoInvestCategoryModel copyWith({
//     String? statusCode,
//     dynamic message,
//     List<Data>? data,
//     dynamic sfLogs,
//   }) =>
//       AutoInvestCategoryModel(
//         statusCode: statusCode ?? _statusCode,
//         message: message ?? _message,
//         data: data ?? _data,
//         sfLogs: sfLogs ?? _sfLogs,
//       );
//   String? get statusCode => _statusCode;
//   dynamic get message => _message;
//   List<Data>? get data => _data;
//   dynamic get sfLogs => _sfLogs;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['statusCode'] = _statusCode;
//     map['message'] = _message;
//     if (_data != null) {
//       map['data'] = _data?.map((v) => v.toJson()).toList();
//     }
//     map['sfLogs'] = _sfLogs;
//     return map;
//   }
// }

/// id : 1
/// categoryType : "Low Risk"
/// conservativeRisk : "70"
/// moderateRisk : "30"
/// highRisk : "0"
/// recommended : false
/// autoInvestmentEnable : true

bool? parseAutoInvestBool(dynamic value) {
  if (value == null) return null;
  if (value is bool) return value;
  if (value is int) return value != 0;
  if (value is String) {
    return value == '\x01' ||
        value == '1' ||
        value.toLowerCase() == 'true' ||
        value == 'Y' ||
        value == 'y';
  }
  return null;
}

class AutoInvestCategoryModel {
  AutoInvestCategoryModel({
    int? id,
    String? categoryType,
    int? amount,
    String? conservativeRisk,
    String? moderateRisk,
    String? highRisk,
    bool? recommended,
    bool? autoInvestmentEnable,
  }) {
    _id = id;
    _amount = amount;
    _categoryType = categoryType;
    _conservativeRisk = conservativeRisk;
    _moderateRisk = moderateRisk;
    _highRisk = highRisk;
    _recommended = recommended;
    _autoInvestmentEnable = autoInvestmentEnable;
  }

  AutoInvestCategoryModel.fromJson(dynamic json) {
    _id = json['id'];
    _amount = json['amount'];
    _categoryType = json['categoryType'];
    _conservativeRisk = json['conservativeRisk'];
    _moderateRisk = json['moderateRisk'];
    _highRisk = json['highRisk'];
    _recommended = parseAutoInvestBool(json['recommended']);
    _autoInvestmentEnable = parseAutoInvestBool(json['autoInvestmentEnable']);
  }
  int? _id;
  int? _amount;
  String? _categoryType;
  String? _conservativeRisk;
  String? _moderateRisk;
  String? _highRisk;
  bool? _recommended;
  bool? _autoInvestmentEnable;
  AutoInvestCategoryModel copyWith({
    int? id,
    int? amount,
    String? categoryType,
    String? conservativeRisk,
    String? moderateRisk,
    String? highRisk,
    bool? recommended,
    bool? autoInvestmentEnable,
  }) =>
      AutoInvestCategoryModel(
        id: id ?? _id,
        amount: amount ?? _amount,
        categoryType: categoryType ?? _categoryType,
        conservativeRisk: conservativeRisk ?? _conservativeRisk,
        moderateRisk: moderateRisk ?? _moderateRisk,
        highRisk: highRisk ?? _highRisk,
        recommended: recommended ?? _recommended,
        autoInvestmentEnable: autoInvestmentEnable ?? _autoInvestmentEnable,
      );
  int? get id => _id;
  int? get amount => _amount;
  String? get categoryType => _categoryType;
  String? get conservativeRisk => _conservativeRisk;
  String? get moderateRisk => _moderateRisk;
  String? get highRisk => _highRisk;
  bool? get recommended => _recommended;
  bool? get autoInvestmentEnable => _autoInvestmentEnable;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['amount'] = _amount;
    map['categoryType'] = _categoryType;
    map['conservativeRisk'] = _conservativeRisk;
    map['moderateRisk'] = _moderateRisk;
    map['highRisk'] = _highRisk;
    map['recommended'] = _recommended;
    map['autoInvestmentEnable'] = _autoInvestmentEnable;
    return map;
  }
}
