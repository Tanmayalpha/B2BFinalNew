import 'dart:convert';
/// error : false
/// message : "Data retrived successfully"
/// data : [{"id":"18","name":"rohit"},{"id":"23","name":"test_sub"}]

GetSubCatModel getSubCatModelFromJson(String str) => GetSubCatModel.fromJson(json.decode(str));
String getSubCatModelToJson(GetSubCatModel data) => json.encode(data.toJson());
class GetSubCatModel {
  GetSubCatModel({
    bool? error,
    String? message,
    List<GetSubData>? data,}){
    _error = error;
    _message = message;
    _data = data;
  }

  GetSubCatModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(GetSubData.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<GetSubData>? _data;
  GetSubCatModel copyWith({  bool? error,
    String? message,
    List<GetSubData>? data,
  }) => GetSubCatModel(  error: error ?? _error,
    message: message ?? _message,
    data: data ?? _data,
  );
  bool? get error => _error;
  String? get message => _message;
  List<GetSubData>? get data => _data;

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

GetSubData dataFromJson(String str) => GetSubData.fromJson(json.decode(str));
String dataToJson(GetSubData data) => json.encode(data.toJson());
class GetSubData {
  GetSubData({
    String? id,
    String? name,}){
    _id = id;
    _name = name;
  }

  GetSubData.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  String? _id;
  String? _name;
  GetSubData copyWith({  String? id,
    String? name,
  }) => GetSubData(  id: id ?? _id,
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