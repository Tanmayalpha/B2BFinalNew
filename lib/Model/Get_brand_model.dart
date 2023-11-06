/// error : false
/// message : "Brands Retrived Successfully"
/// data : [{"id":"2","name":"Pen","image":"httpS://developmentalphawizz.com/B2B/uploads/media/2023/51vOMolqGsL.jpg"},{"id":"4","name":"Havels","image":"httpS://developmentalphawizz.com/B2B/uploads/media/2023/PngItem_942208.png"},{"id":"6","name":"Nivea","image":"httpS://developmentalphawizz.com/B2B/uploads/media/2023/download.png"},{"id":"8","name":"Technical Information","image":"httpS://developmentalphawizz.com/B2B/uploads/media/2023/AlphaWizz_black_logo1.png"},{"id":"9","name":"Bajaj","image":"httpS://developmentalphawizz.com/B2B/uploads/media/2023/Untitled.png"},{"id":"10","name":"Brand service","image":"httpS://developmentalphawizz.com/B2B/uploads/media/2023/Untitled12.jpg"}]

class GetBrandModel {
  GetBrandModel({
      bool? error, 
      String? message, 
      List<GetBrandDataList>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  GetBrandModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(GetBrandDataList.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<GetBrandDataList>? _data;
GetBrandModel copyWith({  bool? error,
  String? message,
  List<GetBrandDataList>? data,
}) => GetBrandModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  List<GetBrandDataList>? get data => _data;

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

/// id : "2"
/// name : "Pen"
/// image : "httpS://developmentalphawizz.com/B2B/uploads/media/2023/51vOMolqGsL.jpg"

class GetBrandDataList {
  GetBrandDataList({
      String? id, 
      String? name, 
      String? image,}){
    _id = id;
    _name = name;
    _image = image;
}

  GetBrandDataList.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _image = json['image'];
  }
  String? _id;
  String? _name;
  String? _image;
GetBrandDataList copyWith({  String? id,
  String? name,
  String? image,
}) => GetBrandDataList(  id: id ?? _id,
  name: name ?? _name,
  image: image ?? _image,
);
  String? get id => _id;
  String? get name => _name;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['image'] = _image;
    return map;
  }

}