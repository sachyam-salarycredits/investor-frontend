/// success : true
/// response_code : 200
/// entity : "collection"
/// user_name : "Abhinav"
/// ext_uid : "7828011085"
/// count : 6
/// items : [{"title":"Spin the Wheel","screen_code":"spin_wheel","icon_url":"https://cdn.theflyy.com/flyy-assets/defaults/partner_offers/SpinIcon.png","id":83},{"title":"Challenge","screen_code":"challenge","icon_url":"https://cdn.theflyy.com/flyy-assets/defaults/partner_offers/Challenges.png","id":9209},{"title":"Quiz","screen_code":"quiz_list","icon_url":"https://cdn.theflyy.com/flyy-assets/defaults/partner_offers/Quiz.png"},{"title":"Collection","screen_code":"stamp_campaign","icon_url":"https://cdn.theflyy.com/flyy-assets/defaults/partner_offers/Stamp.png","id":358},{"title":"Raffle","screen_code":"raffle","icon_url":"https://cdn.theflyy.com/flyy-assets/defaults/partner_offers/RaffleTicket.png","id":114},{"title":"Leaderboard","screen_code":"leaqderboard","icon_url":"https://cdn.theflyy.com/flyy-assets/defaults/partner_offers/Leaderboard.png","id":197}]

class NewOfferModel {
  NewOfferModel({
    NewOfferDetail? data,
    dynamic sfLogs,
  }) {
    _data = data;
    _sfLogs = sfLogs;
  }

  NewOfferModel.fromJson(dynamic json) {
    _data = json['data'] != null ? NewOfferDetail.fromJson(json['data']) : null;
    _sfLogs = json['sfLogs'];
  }
  NewOfferDetail? _data;
  dynamic _sfLogs;
  NewOfferModel copyWith({
    NewOfferDetail? data,
    dynamic sfLogs,
  }) =>
      NewOfferModel(
        data: data ?? _data,
        sfLogs: sfLogs ?? _sfLogs,
      );
  NewOfferDetail? get data => _data;
  dynamic get sfLogs => _sfLogs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['sfLogs'] = _sfLogs;
    return map;
  }
}

class NewOfferDetail {
  NewOfferDetail({
    bool? success,
    int? responseCode,
    String? entity,
    String? userName,
    String? extUid,
    int? count,
    List<Items>? items,
  }) {
    _success = success;
    _responseCode = responseCode;
    _entity = entity;
    _userName = userName;
    _extUid = extUid;
    _count = count;
    _items = items;
  }

  NewOfferDetail.fromJson(dynamic json) {
    _success = json['success'];
    _responseCode = json['response_code'];
    _entity = json['entity'];
    _userName = json['user_name'];
    _extUid = json['ext_uid'];
    _count = json['count'];
    if (json['items'] != null) {
      _items = [];
      json['items'].forEach((v) {
        _items?.add(Items.fromJson(v));
      });
    }
  }
  bool? _success;
  int? _responseCode;
  String? _entity;
  String? _userName;
  String? _extUid;
  int? _count;
  List<Items>? _items;
  NewOfferDetail copyWith({
    bool? success,
    int? responseCode,
    String? entity,
    String? userName,
    String? extUid,
    int? count,
    List<Items>? items,
  }) =>
      NewOfferDetail(
        success: success ?? _success,
        responseCode: responseCode ?? _responseCode,
        entity: entity ?? _entity,
        userName: userName ?? _userName,
        extUid: extUid ?? _extUid,
        count: count ?? _count,
        items: items ?? _items,
      );
  bool? get success => _success;
  int? get responseCode => _responseCode;
  String? get entity => _entity;
  String? get userName => _userName;
  String? get extUid => _extUid;
  int? get count => _count;
  List<Items>? get items => _items;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['response_code'] = _responseCode;
    map['entity'] = _entity;
    map['user_name'] = _userName;
    map['ext_uid'] = _extUid;
    map['count'] = _count;
    if (_items != null) {
      map['items'] = _items?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// title : "Spin the Wheel"
/// screen_code : "spin_wheel"
/// icon_url : "https://cdn.theflyy.com/flyy-assets/defaults/partner_offers/SpinIcon.png"
/// id : 83

class Items {
  Items({
    String? title,
    String? screenCode,
    String? iconUrl,
    String? gifUrl,
    String? fly_vedio_url,
    int? id,
    int? type_id,
  }) {
    _title = title;
    _screenCode = screenCode;
    _iconUrl = iconUrl;
    _gifUrl = gifUrl;
    _fly_vedio_url = fly_vedio_url;
    _id = id;
    _type_id = type_id;
  }

  Items.fromJson(dynamic json) {
    _title = json['title'];
    _screenCode = json['screen_code'];
    _iconUrl = json['icon_url'];
    _gifUrl = json['gif_url'];
    _fly_vedio_url = json['fly_vedio_url'];
    _id = json['id'];
    _type_id = json['type_id'];
  }
  String? _title;
  String? _screenCode;
  String? _iconUrl;
  String? _gifUrl;
  String? _fly_vedio_url;
  int? _id;
  int? _type_id;
  Items copyWith({
    String? title,
    String? screenCode,
    String? iconUrl,
    String? gifUrl,
    String? fly_vedio_url,
    int? id,
    int? type_id,
  }) =>
      Items(
        title: title ?? _title,
        screenCode: screenCode ?? _screenCode,
        iconUrl: iconUrl ?? _iconUrl,
        gifUrl: iconUrl ?? _gifUrl,
        fly_vedio_url: fly_vedio_url ?? _fly_vedio_url,
        id: id ?? _id,
        type_id: type_id ?? _type_id,
      );
  String? get title => _title;
  String? get screenCode => _screenCode;
  String? get iconUrl => _iconUrl;
  String? get gifUrl => _gifUrl;
  String? get fly_vedio_url => _fly_vedio_url;
  int? get id => _id;
  int? get type_id => _type_id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['screen_code'] = _screenCode;
    map['icon_url'] = _iconUrl;
    map['gif_url'] = _gifUrl;
    map['fly_vedio_url'] = _fly_vedio_url;
    map['id'] = _id;
    map['type_id'] = _type_id;
    return map;
  }
}
