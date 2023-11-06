/// error : false
/// message : "Data retrived successfully"
/// data : [{"id":"1","name":"Andaman and Nicobar Islands","country_id":"101"},{"id":"2","name":"Andhra Pradesh","country_id":"101"},{"id":"3","name":"Arunachal Pradesh","country_id":"101"},{"id":"4","name":"Assam","country_id":"101"},{"id":"5","name":"Bihar","country_id":"101"},{"id":"6","name":"Chandigarh","country_id":"101"},{"id":"7","name":"Chhattisgarh","country_id":"101"},{"id":"8","name":"Dadra and Nagar Haveli","country_id":"101"},{"id":"9","name":"Daman and Diu","country_id":"101"},{"id":"10","name":"Delhi","country_id":"101"},{"id":"11","name":"Goa","country_id":"101"},{"id":"12","name":"Gujarat","country_id":"101"},{"id":"13","name":"Haryana","country_id":"101"},{"id":"14","name":"Himachal Pradesh","country_id":"101"},{"id":"15","name":"Jammu and Kashmir","country_id":"101"},{"id":"16","name":"Jharkhand","country_id":"101"},{"id":"17","name":"Karnataka","country_id":"101"},{"id":"18","name":"Kenmore","country_id":"101"},{"id":"19","name":"Kerala","country_id":"101"},{"id":"20","name":"Lakshadweep","country_id":"101"},{"id":"21","name":"Madhya Pradesh","country_id":"101"},{"id":"22","name":"Maharashtra","country_id":"101"},{"id":"23","name":"Manipur","country_id":"101"},{"id":"24","name":"Meghalaya","country_id":"101"},{"id":"25","name":"Mizoram","country_id":"101"},{"id":"26","name":"Nagaland","country_id":"101"},{"id":"27","name":"Narora","country_id":"101"},{"id":"28","name":"Natwar","country_id":"101"},{"id":"29","name":"Odisha","country_id":"101"},{"id":"30","name":"Paschim Medinipur","country_id":"101"},{"id":"31","name":"Pondicherry","country_id":"101"},{"id":"32","name":"Punjab","country_id":"101"},{"id":"33","name":"Rajasthan","country_id":"101"},{"id":"34","name":"Sikkim","country_id":"101"},{"id":"35","name":"Tamil Nadu","country_id":"101"},{"id":"36","name":"Telangana","country_id":"101"},{"id":"37","name":"Tripura","country_id":"101"},{"id":"38","name":"Uttar Pradesh","country_id":"101"},{"id":"39","name":"Uttarakhand","country_id":"101"},{"id":"40","name":"Vaishali","country_id":"101"},{"id":"41","name":"West Bengal","country_id":"101"}]

class GetStateModel {
  GetStateModel({
    bool? error,
    String? message,
    List<StateData>? data,}){
    _error = error;
    _message = message;
    _data = data;
  }

  GetStateModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(StateData.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<StateData>? _data;
  GetStateModel copyWith({  bool? error,
    String? message,
    List<StateData>? data,
  }) => GetStateModel(  error: error ?? _error,
    message: message ?? _message,
    data: data ?? _data,
  );
  bool? get error => _error;
  String? get message => _message;
  List<StateData>? get data => _data;

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
/// name : "Andaman and Nicobar Islands"
/// country_id : "101"

class StateData {
  StateData({
    String? id,
    String? name,
    String? countryId,}){
    _id = id;
    _name = name;
    _countryId = countryId;
  }

  StateData.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _countryId = json['country_id'];
  }
  String? _id;
  String? _name;
  String? _countryId;
  StateData copyWith({  String? id,
    String? name,
    String? countryId,
  }) => StateData(  id: id ?? _id,
    name: name ?? _name,
    countryId: countryId ?? _countryId,
  );
  String? get id => _id;
  String? get name => _name;
  String? get countryId => _countryId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['country_id'] = _countryId;
    return map;
  }

}