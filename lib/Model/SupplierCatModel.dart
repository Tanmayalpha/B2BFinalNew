/// error : false
/// message : "Data retrived successfully"
/// data : [{"id":"111111","name":"Select All","created_date":"2023-10-16 11:42:31","updated_date":"2023-10-19 10:48:14"},{"id":"20","name":"Import/Export","created_date":"2023-09-15 13:39:35","updated_date":"2023-10-06 18:38:28"},{"id":"19","name":"Business service","created_date":"2023-09-15 13:39:35","updated_date":"2023-09-25 21:34:23"},{"id":"18","name":"Pharma company","created_date":"2023-08-28 17:18:15","updated_date":"2023-09-22 15:00:05"},{"id":"17","name":"Sumit Patel","created_date":"2023-08-28 11:53:25","updated_date":"2023-08-28 11:53:25"},{"id":"16","name":"Farmer","created_date":"2023-08-01 16:38:55","updated_date":"2023-08-01 16:38:55"},{"id":"15","name":"Stainless Steel Business","created_date":"2023-07-14 15:24:40","updated_date":"2023-07-14 15:32:11"},{"id":"13","name":"Stationary Business","created_date":"2023-07-14 11:21:29","updated_date":"2023-07-14 11:21:29"},{"id":"12","name":"Vegetable Business","created_date":"2023-07-14 11:20:49","updated_date":"2023-07-14 11:20:49"},{"id":"10","name":"Service Provider","created_date":"2023-06-28 16:25:37","updated_date":"2023-07-14 11:07:36"},{"id":"9","name":"Investors","created_date":"2023-06-26 12:16:47","updated_date":"2023-06-26 12:16:47"},{"id":"6","name":"Retailers","created_date":"2023-06-26 12:16:17","updated_date":"2023-06-26 12:16:17"},{"id":"2","name":"Wholesaler","created_date":"2023-06-13 17:16:50","updated_date":"2023-06-13 20:26:24"},{"id":"1","name":"Manufacturers","created_date":"2023-06-13 17:16:43","updated_date":"2023-06-28 09:40:31"}]

class SupplierCatModel {
  SupplierCatModel({
      bool? error, 
      String? message, 
      List<BussinessData>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  SupplierCatModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(BussinessData.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<BussinessData>? _data;
SupplierCatModel copyWith({  bool? error,
  String? message,
  List<BussinessData>? data,
}) => SupplierCatModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  List<BussinessData>? get data => _data;

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

/// id : "111111"
/// name : "Select All"
/// created_date : "2023-10-16 11:42:31"
/// updated_date : "2023-10-19 10:48:14"

class BussinessData {
  BussinessData({
      String? id, 
      String? name, 
      String? createdDate, 
      String? updatedDate,}){
    _id = id;
    _name = name;
    _createdDate = createdDate;
    _updatedDate = updatedDate;
}

  BussinessData.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _createdDate = json['created_date'];
    _updatedDate = json['updated_date'];
  }
  String? _id;
  String? _name;
  String? _createdDate;
  String? _updatedDate;
BussinessData copyWith({  String? id,
  String? name,
  String? createdDate,
  String? updatedDate,
}) => BussinessData(  id: id ?? _id,
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