/// error : false
/// message : "Community retrieved successfully !"
/// data : [{"id":"1","name":"rohti","mobile":"7878787878","city":"imdpre","image":"","user_id":"1"},{"id":"2","name":"flklkjalsdf","mobile":"6546546","city":"rajkot","image":"uploads/media/2023/adcloth3.jpg","user_id":"394"},{"id":"3","name":"wasim","mobile":"7974072472","city":"Indore","image":"uploads/media/2023/cake-banner.jpg","user_id":"447"},{"id":"4","name":"Harish","mobile":"8770669964","city":"indore","image":"uploads/media/2023/tiles4.jpg","user_id":"440"},{"id":"5","name":"Sonam","mobile":"7974046161","city":"Indore","image":"uploads/media/2023/tiles4.jpg","user_id":"440"},{"id":"9","name":"Devesh","mobile":"8349922853","city":"Jabalpur","image":"uploads/media/2023/tiles4.jpg","user_id":"440"},{"id":"13","name":"Harish","mobile":"8319394805","city":"indore","image":"uploads/media/2023/cake-banner.jpg","user_id":"447"},{"id":"14","name":"Abhishek","mobile":"7855444474","city":"Indore","image":"uploads/media/2023/food-image2.jpg","user_id":"474"},{"id":"15","name":"rohti","mobile":"7878787878","city":"imdpre","image":"","user_id":"1"},{"id":"16","name":"Testing","mobile":"96582369852","city":"indore","image":"uploads/media/2023/oil4.jpg","user_id":"400"},{"id":"18","name":"asdfs","mobile":"9090909090","city":"asdf","image":"uploads/media/2023/oil4.jpg","user_id":"400"},{"id":"19","name":"9090909090","mobile":"9090909090","city":"9090909090","image":"uploads/media/2023/oil4.jpg","user_id":"400"},{"id":"20","name":"Rohti","mobile":"9090909090","city":"sadf","image":"","user_id":"400"},{"id":"21","name":"adfadf","mobile":"9090909090","city":"sdaf","image":"uploads/media/2023/oil4.jpg","user_id":"400"},{"id":"22","name":"asdfasd","mobile":"9090909090","city":"sadf","image":"uploads/media/2023/oil4.jpg","user_id":"400"}]

class GetCommunityModel {
  GetCommunityModel({
      bool? error, 
      String? message, 
      List<Data>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  GetCommunityModel.fromJson(dynamic json) {
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
GetCommunityModel copyWith({  bool? error,
  String? message,
  List<Data>? data,
}) => GetCommunityModel(  error: error ?? _error,
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
/// name : "rohti"
/// mobile : "7878787878"
/// city : "imdpre"
/// image : ""
/// user_id : "1"

class Data {
  Data({
      String? id, 
      String? name, 
      String? mobile, 
      String? city, 
      String? image, 
      String? userId,}){
    _id = id;
    _name = name;
    _mobile = mobile;
    _city = city;
    _image = image;
    _userId = userId;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _mobile = json['mobile'];
    _city = json['city'];
    _image = json['image'];
    _userId = json['user_id'];
  }
  String? _id;
  String? _name;
  String? _mobile;
  String? _city;
  String? _image;
  String? _userId;
Data copyWith({  String? id,
  String? name,
  String? mobile,
  String? city,
  String? image,
  String? userId,
}) => Data(  id: id ?? _id,
  name: name ?? _name,
  mobile: mobile ?? _mobile,
  city: city ?? _city,
  image: image ?? _image,
  userId: userId ?? _userId,
);
  String? get id => _id;
  String? get name => _name;
  String? get mobile => _mobile;
  String? get city => _city;
  String? get image => _image;
  String? get userId => _userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['mobile'] = _mobile;
    map['city'] = _city;
    map['image'] = _image;
    map['user_id'] = _userId;
    return map;
  }

}