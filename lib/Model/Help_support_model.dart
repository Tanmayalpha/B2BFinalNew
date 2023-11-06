/// error : false
/// message : "Support Video Get Sucessfully !"
/// data : [{"id":"4","video":"uploads/media/2023/Probe42_Business_1_Min.mp4","title":"Help & Support","created_at":"2023-09-12 12:20:23"}]

class HelpSupportModel {
  HelpSupportModel({
      bool? error, 
      String? message, 
      List<Data>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  HelpSupportModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<Data>? _data;
HelpSupportModel copyWith({  bool? error,
  String? message,
  List<Data>? data,
}) => HelpSupportModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "4"
/// video : "uploads/media/2023/Probe42_Business_1_Min.mp4"
/// title : "Help & Support"
/// created_at : "2023-09-12 12:20:23"

class Data {
  Data({
      String? id, 
      String? video, 
      String? title, 
      String? createdAt,}){
    _id = id;
    _video = video;
    _title = title;
    _createdAt = createdAt;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _video = json['video'];
    _title = json['title'];
    _createdAt = json['created_at'];
  }
  String? _id;
  String? _video;
  String? _title;
  String? _createdAt;
Data copyWith({  String? id,
  String? video,
  String? title,
  String? createdAt,
}) => Data(  id: id ?? _id,
  video: video ?? _video,
  title: title ?? _title,
  createdAt: createdAt ?? _createdAt,
);
  String? get id => _id;
  String? get video => _video;
  String? get title => _title;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['video'] = _video;
    map['title'] = _title;
    map['created_at'] = _createdAt;
    return map;
  }

}