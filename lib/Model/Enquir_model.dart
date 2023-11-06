/// error : false
/// message : "List retrieved successfully !"
/// data : [{"id":"96","mobile":"08770669964","product_id":"267","user_id":null,"city":"indore","name":"Rohti","type":null,"created_at":"2023-10-13 19:02:05"},{"id":"101","mobile":"08770669964","product_id":"267","user_id":null,"city":"dfkladf","name":"Rohti","type":null,"created_at":"2023-10-13 19:03:55"},{"id":"102","mobile":"08770669964","product_id":"267","user_id":"1","city":"dfkladf","name":"Rohti","type":null,"created_at":"2023-10-13 19:04:03"},{"id":"104","mobile":"08770669964","product_id":"267","user_id":"1","city":"dfkladf","name":"Rohti","type":null,"created_at":"2023-10-13 19:05:12"},{"id":"105","mobile":"08770669964","product_id":"267","user_id":"699","city":"dfkladf","name":"Rohti","type":null,"created_at":"2023-10-13 19:05:54"}]

class EnquirModel {
  EnquirModel({
      bool? error, 
      String? message, 
      List<Data>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  EnquirModel.fromJson(dynamic json) {
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
EnquirModel copyWith({  bool? error,
  String? message,
  List<Data>? data,
}) => EnquirModel(  error: error ?? _error,
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

/// id : "96"
/// mobile : "08770669964"
/// product_id : "267"
/// user_id : null
/// city : "indore"
/// name : "Rohti"
/// type : null
/// created_at : "2023-10-13 19:02:05"

class Data {
  Data({
      String? id, 
      String? mobile, 
      String? productId, 
      dynamic userId, 
      String? city, 
      String? name, 
      dynamic type, 
      String? createdAt,}){
    _id = id;
    _mobile = mobile;
    _productId = productId;
    _userId = userId;
    _city = city;
    _name = name;
    _type = type;
    _createdAt = createdAt;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _mobile = json['mobile'];
    _productId = json['product_id'];
    _userId = json['user_id'];
    _city = json['city'];
    _name = json['name'];
    _type = json['type'];
    _createdAt = json['created_at'];
  }
  String? _id;
  String? _mobile;
  String? _productId;
  dynamic _userId;
  String? _city;
  String? _name;
  dynamic _type;
  String? _createdAt;
Data copyWith({  String? id,
  String? mobile,
  String? productId,
  dynamic userId,
  String? city,
  String? name,
  dynamic type,
  String? createdAt,
}) => Data(  id: id ?? _id,
  mobile: mobile ?? _mobile,
  productId: productId ?? _productId,
  userId: userId ?? _userId,
  city: city ?? _city,
  name: name ?? _name,
  type: type ?? _type,
  createdAt: createdAt ?? _createdAt,
);
  String? get id => _id;
  String? get mobile => _mobile;
  String? get productId => _productId;
  dynamic get userId => _userId;
  String? get city => _city;
  String? get name => _name;
  dynamic get type => _type;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['mobile'] = _mobile;
    map['product_id'] = _productId;
    map['user_id'] = _userId;
    map['city'] = _city;
    map['name'] = _name;
    map['type'] = _type;
    map['created_at'] = _createdAt;
    return map;
  }

}