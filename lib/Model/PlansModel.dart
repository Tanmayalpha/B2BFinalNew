/// error : false
/// message : "Plans retrieved Sucessfully"
/// data : [{"id":"1","title":"Free Plan","description":"we provide best advertisement for all","plan_cat":"Advertisement","sub_cat":"Slider","price":"154515700","selling_price":"154515700","duration":"30","benifits":"500","status":"1","created_at":"2023-09-21 22:55:16","is_purchased":false},{"id":"3","title":"Quarter plan","description":"3 month","plan_cat":"Listing Preference","sub_cat":"4 Rank","price":"5000","selling_price":"5000","duration":"90","benifits":"200","status":"1","created_at":"2023-08-31 16:49:52","is_purchased":false},{"id":"11","title":"1 year package","description":"b2b company","plan_cat":"Membership","sub_cat":"Paid Package","price":"7500","selling_price":"4500","duration":"90","benifits":"100","status":"1","created_at":"2023-09-13 11:52:10","is_purchased":false},{"id":"14","title":"Lipika","description":"Test the Admin page","plan_cat":"Membership","sub_cat":"Paid Package","price":"1800","selling_price":"1500","duration":"90","benifits":"100","status":"1","created_at":"2023-09-13 11:52:12","is_purchased":false},{"id":"15","title":"Advertisement","description":"Advertisement","plan_cat":"Advertisement","sub_cat":"Right Panel","price":"200","selling_price":"100","duration":"90","benifits":"100","status":"1","created_at":"2023-07-18 13:03:51","is_purchased":false},{"id":"16","title":"For 1 year","description":"validate for 1 year","plan_cat":"Membership","sub_cat":"Paid Package","price":"500","selling_price":"500","duration":"90","benifits":"400","status":"1","created_at":"2023-09-13 11:52:13","is_purchased":false},{"id":"17","title":"E larning platform","description":"we provided the best course","plan_cat":"Membership","sub_cat":"Free Package","price":"2147","selling_price":"2146","duration":"90","benifits":"500","status":"1","created_at":"2023-09-13 11:52:14","is_purchased":false},{"id":"18","title":"6 month","description":"6 month","plan_cat":"Membership","sub_cat":"Paid Package","price":"6000","selling_price":"4500","duration":"90","benifits":"100","status":"1","created_at":"2023-09-13 11:52:15","is_purchased":false},{"id":"19","title":"year plan","description":"ABC","plan_cat":"Membership","sub_cat":"Paid Package","price":"5000","selling_price":"10000","duration":"","benifits":"500","status":"1","created_at":"2023-09-15 14:50:14","is_purchased":false},{"id":"20","title":"Test Paln","description":"good plan","plan_cat":"Membership","sub_cat":"Free Package","price":"1000","selling_price":"1500","duration":"","benifits":"","status":"1","created_at":"2023-09-22 15:08:40","is_purchased":false}]

class PlansModel {
  PlansModel({
      bool? error, 
      String? message, 
      List<Data>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  PlansModel.fromJson(dynamic json) {
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
PlansModel copyWith({  bool? error,
  String? message,
  List<Data>? data,
}) => PlansModel(  error: error ?? _error,
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

/// id : "1"
/// title : "Free Plan"
/// description : "we provide best advertisement for all"
/// plan_cat : "Advertisement"
/// sub_cat : "Slider"
/// price : "154515700"
/// selling_price : "154515700"
/// duration : "30"
/// benifits : "500"
/// status : "1"
/// created_at : "2023-09-21 22:55:16"
/// is_purchased : false

class Data {
  Data({
      String? id, 
      String? title, 
      String? description, 
      String? planCat, 
      String? subCat, 
      String? price, 
      String? sellingPrice, 
      String? duration, 
      String? benifits, 
      String? status, 
      String? createdAt, 
      bool? isPurchased,}){
    _id = id;
    _title = title;
    _description = description;
    _planCat = planCat;
    _subCat = subCat;
    _price = price;
    _sellingPrice = sellingPrice;
    _duration = duration;
    _benifits = benifits;
    _status = status;
    _createdAt = createdAt;
    _isPurchased = isPurchased;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _description = json['description'];
    _planCat = json['plan_cat'];
    _subCat = json['sub_cat'];
    _price = json['price'];
    _sellingPrice = json['selling_price'];
    _duration = json['duration'];
    _benifits = json['benifits'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _isPurchased = json['is_purchased'];
  }
  String? _id;
  String? _title;
  String? _description;
  String? _planCat;
  String? _subCat;
  String? _price;
  String? _sellingPrice;
  String? _duration;
  String? _benifits;
  String? _status;
  String? _createdAt;
  bool? _isPurchased;
Data copyWith({  String? id,
  String? title,
  String? description,
  String? planCat,
  String? subCat,
  String? price,
  String? sellingPrice,
  String? duration,
  String? benifits,
  String? status,
  String? createdAt,
  bool? isPurchased,
}) => Data(  id: id ?? _id,
  title: title ?? _title,
  description: description ?? _description,
  planCat: planCat ?? _planCat,
  subCat: subCat ?? _subCat,
  price: price ?? _price,
  sellingPrice: sellingPrice ?? _sellingPrice,
  duration: duration ?? _duration,
  benifits: benifits ?? _benifits,
  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  isPurchased: isPurchased ?? _isPurchased,
);
  String? get id => _id;
  String? get title => _title;
  String? get description => _description;
  String? get planCat => _planCat;
  String? get subCat => _subCat;
  String? get price => _price;
  String? get sellingPrice => _sellingPrice;
  String? get duration => _duration;
  String? get benifits => _benifits;
  String? get status => _status;
  String? get createdAt => _createdAt;
  bool? get isPurchased => _isPurchased;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['description'] = _description;
    map['plan_cat'] = _planCat;
    map['sub_cat'] = _subCat;
    map['price'] = _price;
    map['selling_price'] = _sellingPrice;
    map['duration'] = _duration;
    map['benifits'] = _benifits;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['is_purchased'] = _isPurchased;
    return map;
  }

}