class DelinquencyStatusModel {
  DelinquencyStatusModel({
    this.message,
    this.data,
    this.sfLogs,
  });

  DelinquencyStatusModel.fromJson(dynamic json) {
    message = json['message'];
    data = json['data'];
    sfLogs = json['sfLogs'];
  }
  String? message;
  String? data;
  dynamic? sfLogs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['data'] = data;
    map['sfLogs'] = sfLogs;
    return map;
  }
}
