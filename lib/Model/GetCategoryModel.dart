/// error : false
/// message : "Data retrived successfully"
/// data : [{"id":"1","name":"vinay"},{"id":"2","name":"KitchenWare"},{"id":"3","name":"Furniture"},{"id":"10","name":"Builder"},{"id":"12","name":"Creamic consumable"},{"id":"14","name":"Computer Hardware"},{"id":"16","name":"Electrical"},{"id":"19","name":"adsfasd"},{"id":"21","name":"new category123"},{"id":"22","name":"service provider"},{"id":"24","name":"Harish 1"},{"id":"25","name":"Agriculture"},{"id":"27","name":"Snacks"},{"id":"29","name":"Ayurvedic"},{"id":"31","name":"Beverages"},{"id":"33","name":"Lights and decoration"},{"id":"35","name":"Chairs"},{"id":"37","name":"Jewellery & diamond"},{"id":"39","name":"Paper and files"},{"id":"41","name":"mobile"},{"id":"42","name":"inkjety printer"},{"id":"43","name":"printer"},{"id":"44","name":"printer xerox"}]

class GetCategoryModel {
  GetCategoryModel({
    bool? error,
    String? message,
    List<CategoryData>? data,}){
    _error = error;
    _message = message;
    _data = data;
  }

  GetCategoryModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(CategoryData.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<CategoryData>? _data;
  GetCategoryModel copyWith({  bool? error,
    String? message,
    List<CategoryData>? data,
  }) => GetCategoryModel(  error: error ?? _error,
    message: message ?? _message,
    data: data ?? _data,
  );
  bool? get error => _error;
  String? get message => _message;
  List<CategoryData>? get data => _data;

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
/// name : "vinay"

class CategoryData {
  CategoryData({
    String? id,
    String? name,}){
    _id = id;
    _name = name;
  }

  CategoryData.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  String? _id;
  String? _name;
  CategoryData copyWith({  String? id,
    String? name,
  }) => CategoryData(  id: id ?? _id,
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