/// error : false
/// message : "Data retrived successfully"
/// data : [{"id":"18","name":"rohit"},{"id":"23","name":"test_sub"}]

class GetSubCategoryModel {
  GetSubCategoryModel({
    bool? error,
    String? message,
    List<SubCategoryData>? data,}) {
    _error = error;
    _message = message;
    _data = data;
  }

  GetSubCategoryModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(SubCategoryData.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<SubCategoryData>? _data;
  GetSubCategoryModel copyWith({  bool? error,
    String? message,
    List<SubCategoryData>? data,
  }) => GetSubCategoryModel(  error: error ?? _error,
    message: message ?? _message,
    data: data ?? _data,
  );
  bool? get error => _error;
  String? get message => _message;
  List<SubCategoryData>? get data => _data;

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

/// id : "18"
/// name : "rohit"

class SubCategoryData {
  SubCategoryData({
    String? id,
    String? name,}){
    _id = id;
    _name = name;
  }

  SubCategoryData.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  String? _id;
  String? _name;
  SubCategoryData copyWith({  String? id,
    String? name,
  }) => SubCategoryData(  id: id ?? _id,
    name: name ?? _name,
  );
  String? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }

}