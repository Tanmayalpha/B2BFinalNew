/// error : false
/// message : "Data retrived successfully"
/// data : [{"id":"1","name":"Manufacturers","created_date":"2023-06-13 17:16:43","updated_date":"2023-06-28 09:40:31"},{"id":"2","name":"Wholesaler","created_date":"2023-06-13 17:16:50","updated_date":"2023-06-13 20:26:24"},{"id":"6","name":"Retailers","created_date":"2023-06-26 12:16:17","updated_date":"2023-06-26 12:16:17"},{"id":"7","name":"Import","created_date":"2023-06-26 12:16:26","updated_date":"2023-06-26 12:16:26"},{"id":"8","name":"Export","created_date":"2023-06-26 12:16:34","updated_date":"2023-06-26 12:16:34"},{"id":"9","name":"Investors","created_date":"2023-06-26 12:16:47","updated_date":"2023-06-26 12:16:47"},{"id":"10","name":"service provider","created_date":"2023-06-28 16:25:37","updated_date":"2023-06-28 16:25:37"}]

class BusinessCategoruModel {
  BusinessCategoruModel({
      bool? error, 
      String? message, 
      List<SellerTypeData>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  BusinessCategoruModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(SellerTypeData.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<SellerTypeData>? _data;
BusinessCategoruModel copyWith({  bool? error,
  String? message,
  List<SellerTypeData>? data,
}) => BusinessCategoruModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  List<SellerTypeData>? get data => _data;

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
/// name : "Manufacturers"
/// created_date : "2023-06-13 17:16:43"
/// updated_date : "2023-06-28 09:40:31"

class SellerTypeData {
  SellerTypeData({
      String? id,
       String? selectAll,
      String? name, 
      String? createdDate, 
      String? updatedDate,}){
    _id = id;
    _name = name;
    _createdDate = createdDate;
    _updatedDate = updatedDate;
    _selectAll =  selectAll;
}

  SellerTypeData.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _createdDate = json['created_date'];
    _updatedDate = json['updated_date'];
    _selectAll = json['Select All'];
  }
  String? _id;
  String? _name;
  String? _createdDate;
  String? _updatedDate;
  String? _selectAll;
SellerTypeData copyWith({  String? id,
  String? name,
  String? createdDate,
  String? updatedDate,
}) => SellerTypeData(  id: id ?? _id,
  name: name ?? _name,
  createdDate: createdDate ?? _createdDate,
  updatedDate: updatedDate ?? _updatedDate,
);
  String? get id => _id;
  String? get name => _name;
  String? get createdDate => _createdDate;
  String? get updatedDate => _updatedDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['created_date'] = _createdDate;
    map['updated_date'] = _updatedDate;
    return map;
  }

}