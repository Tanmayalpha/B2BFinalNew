import 'dart:convert';
/// error : false
/// message : "Data retrived successfully"
/// data : [{"id":"1","name":"Vinay"},{"id":"2","name":"KitchenWare"},{"id":"3","name":"Furniture"},{"id":"10","name":"Builder"},{"id":"12","name":"Creamic consumable"},{"id":"14","name":"Computer Hardware"},{"id":"16","name":"Electrical"},{"id":"19","name":"adsfasd"},{"id":"21","name":"new category123"},{"id":"22","name":"service provider"},{"id":"24","name":"Harish 1"},{"id":"25","name":"Agriculture"},{"id":"27","name":"Snacks"},{"id":"29","name":"Ayurvedic"},{"id":"31","name":"Beverages"},{"id":"33","name":"Lights and decoration"},{"id":"35","name":"Chairs"},{"id":"37","name":"Jewellery & diamond"},{"id":"39","name":"Paper and files"},{"id":"41","name":"mobile"},{"id":"42","name":"inkjety printer"},{"id":"43","name":"printer"},{"id":"44","name":"printer xerox"}]

GetCatModel getCatModelFromJson(String str) => GetCatModel.fromJson(json.decode(str));
String getCatModelToJson(GetCatModel data) => json.encode(data.toJson());
class GetCatModel {
  GetCatModel({
    bool? error,
    String? message,
    List<GetCatDataList>? data,}){
    _error = error;
    _message = message;
    _data = data;
  }

  GetCatModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(GetCatDataList.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<GetCatDataList>? _data;
  GetCatModel copyWith({  bool? error,
    String? message,
    List<GetCatDataList>? data,
  }) => GetCatModel(  error: error ?? _error,
    message: message ?? _message,
    data: data ?? _data,
  );
  bool? get error => _error;
  String? get message => _message;
  List<GetCatDataList>? get data => _data;

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

/// id : "1"
/// name : "Vinay"

GetCatDataList dataFromJson(String str) => GetCatDataList.fromJson(json.decode(str));
String dataToJson(GetCatDataList data) => json.encode(data.toJson());
class GetCatDataList {
  GetCatDataList({
    String? id,
    String? name,}){
    _id = id;
    _name = name;
  }

  GetCatDataList.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  String? _id;
  String? _name;
  GetCatDataList copyWith({  String? id,
    String? name,
  }) => GetCatDataList(  id: id ?? _id,
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

  @override
  String toString() {
    return name??""; // You can use any property of the model that you want to display in the DropdownButton.
  }
}