/// error : false
/// message : "Data retrived successfully"
/// data : [{"name":"test","id":"2","category_id":"1","sub_cat_id":"0"},{"name":"Living Room Furniture","id":"9","category_id":"1","sub_cat_id":"0"},{"name":"Universal Furniture","id":"10","category_id":"1","sub_cat_id":"5"},{"name":"Bedroom Furniture","id":"11","category_id":"4","sub_cat_id":"5"},{"name":"Solid Wood Furniture","id":"12","category_id":"1","sub_cat_id":"0"},{"name":"Wooden Furniture","id":"13","category_id":"1","sub_cat_id":"0"},{"name":"tast2","id":"17","category_id":"1","sub_cat_id":"0"},{"name":"test","id":"19","category_id":"4","sub_cat_id":"5"},{"name":"test","id":"34","category_id":"4","sub_cat_id":"5"}]

class GetProductListModel {
  GetProductListModel({
    bool? error,
    String? message,
    List<ProductList>? data,}){
    _error = error;
    _message = message;
    _data = data;
  }

  GetProductListModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(ProductList.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<ProductList>? _data;
  GetProductListModel copyWith({  bool? error,
    String? message,
    List<ProductList>? data,
  }) => GetProductListModel(  error: error ?? _error,
    message: message ?? _message,
    data: data ?? _data,
  );
  bool? get error => _error;
  String? get message => _message;
  List<ProductList>? get data => _data;

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

/// name : "test"
/// id : "2"
/// category_id : "1"
/// sub_cat_id : "0"

class ProductList {
  ProductList({
    String? name,
    bool? isSelected,
    String? id,
    String? categoryId,
    String? subCatId,}){
    _name = name;
    _id = id;
    _categoryId = categoryId;
    _subCatId = subCatId;
  }

  ProductList.fromJson(dynamic json) {
    _name = json['name'];
    _id = json['id'];
    _categoryId = json['category_id'];
    _subCatId = json['sub_cat_id'];
     isSelected = false ;
  }
  String? _name;
  bool? isSelected;
  String? _id;
  String? _categoryId;
  String? _subCatId;
  ProductList copyWith({  String? name,
    String? id,
    String? categoryId,
    String? subCatId,
  }) => ProductList(  name: name ?? _name,
    id: id ?? _id,
    categoryId: categoryId ?? _categoryId,
    subCatId: subCatId ?? _subCatId,
  );
  String? get name => _name;
  String? get id => _id;
  String? get categoryId => _categoryId;
  String? get subCatId => _subCatId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['id'] = _id;
    map['category_id'] = _categoryId;
    map['sub_cat_id'] = _subCatId;
    return map;
  }

}