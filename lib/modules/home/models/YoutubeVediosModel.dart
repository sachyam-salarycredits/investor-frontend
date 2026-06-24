/// data : [{"id":1,"videoType":"HomeScreen","videoUrl":"https://www.youtube.com/watch?v=No_J9rwBiO8"},{"id":2,"videoType":"FundTransfer","videoUrl":"https://www.youtube.com/shorts/9G8koRNbhw4"}]
/// sfLogs : null

class YoutubeVideosModel {
  YoutubeVideosModel({
    List<VideoData>? data,
    dynamic sfLogs,
  }) {
    _data = data;
    _sfLogs = sfLogs;
  }

  YoutubeVideosModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(VideoData.fromJson(v));
      });
    }
    _sfLogs = json['sfLogs'];
  }
  List<VideoData>? _data;
  dynamic _sfLogs;
  YoutubeVideosModel copyWith({
    List<VideoData>? data,
    dynamic sfLogs,
  }) =>
      YoutubeVideosModel(
        data: data ?? _data,
        sfLogs: sfLogs ?? _sfLogs,
      );
  List<VideoData>? get data => _data;
  dynamic get sfLogs => _sfLogs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['sfLogs'] = _sfLogs;
    return map;
  }
}

/// id : 1
/// videoType : "HomeScreen"
/// videoUrl : "https://www.youtube.com/watch?v=No_J9rwBiO8"

class VideoData {
  VideoData({
    int? id,
    String? videoType,
    String? videoUrl,
    String? thumbnailUrl,
  }) {
    _id = id;
    _videoType = videoType;
    _videoUrl = videoUrl;
    _thumbnailUrl = thumbnailUrl;
  }

  VideoData.fromJson(dynamic json) {
    _id = json['id'];
    _videoType = json['videoType'];
    _videoUrl = json['videoUrl'];
    _thumbnailUrl = json['thumbnailUrl'];
  }
  int? _id;
  String? _videoType;
  String? _videoUrl;
  String? _thumbnailUrl;
  VideoData copyWith({
    int? id,
    String? videoType,
    String? videoUrl,
    String? thumbnailUrl,
  }) =>
      VideoData(
        id: id ?? _id,
        videoType: videoType ?? _videoType,
        videoUrl: videoUrl ?? _videoUrl,
        thumbnailUrl : thumbnailUrl ?? _thumbnailUrl,
      );
  int? get id => _id;
  String? get videoType => _videoType;
  String? get videoUrl => _videoUrl;
  String? get thumbnailUrl => _thumbnailUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['videoType'] = _videoType;
    map['videoUrl'] = _videoUrl;
    map['thumbnailUrl'] = _thumbnailUrl;
    return map;
  }
}
