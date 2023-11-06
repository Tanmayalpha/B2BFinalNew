/// city : [{"value":"Bhopal","label":"Bhopal","data":{"state":"Madhya Pradesh","id":"70588","stateid":"6488","flname":"bhopal"}},{"value":"Bhongaon","label":"Bhongaon","data":{"state":"Uttar Pradesh","id":"84197","stateid":"6499","flname":"bhongaon"}},{"value":"Bhogaon","label":"Bhogaon","data":{"state":"Uttar Pradesh","id":"77510","stateid":"6499","flname":"bhogaon"}},{"value":"Bhognipur","label":"Bhognipur","data":{"state":"Uttar Pradesh","id":"77511","stateid":"6499","flname":"bhognipur"}},{"value":"Bhogpur","label":"Bhogpur","data":{"state":"Punjab","id":"98810","stateid":"6495","flname":"bhogpur"}},{"value":"Bhojpur Dharampur","label":"Bhojpur Dharampur","data":{"state":"Uttar Pradesh","id":"98811","stateid":"6499","flname":"bhojpur-dharampur"}},{"value":"Bhojudih","label":"Bhojudih","data":{"state":"Jharkhand","id":"98812","stateid":"6484","flname":"bhojudih"}},{"value":"Bhokar","label":"Bhokar","data":{"state":"Maharashtra","id":"78937","stateid":"6489","flname":"bhokar"}},{"value":"Bhokardan","label":"Bhokardan","data":{"state":"Maharashtra","id":"78938","stateid":"6489","flname":"bhokardan"}},{"value":"Bhokarhedi","label":"Bhokarhedi","data":{"state":"Uttar Pradesh","id":"98813","stateid":"6499","flname":"bhokarhedi"}},{"value":"Bholar Dabri","label":"Bholar Dabri","data":{"state":"West Bengal","id":"98814","stateid":"6501","flname":"bholar-dabri"}},{"value":"Bhondsi","label":"Bhondsi","data":{"state":"Haryana","id":"98815","stateid":"6481","flname":"bhondsi"}},{"value":"Bhongir","label":"Bhongir","data":{"state":"Telangana","id":"77774","stateid":"7705","flname":"bhongir"}},{"value":"Bhonrasa","label":"Bhonrasa","data":{"state":"Madhya Pradesh","id":"100029","stateid":"6488","flname":"bhonrasa"}},{"value":"Bhoom","label":"Bhoom","data":{"state":"Maharashtra","id":"78939","stateid":"6489","flname":"bhoom"}},{"value":"Bhooragamphad","label":"Bhooragamphad","data":{"state":"Telangana","id":"77775","stateid":"7705","flname":"bhooragamphad"}},{"value":"Bhopalpatnam","label":"Bhopalpatnam","data":{"state":"Chhattisgarh","id":"78127","stateid":"6476","flname":"bhopalpatnam"}},{"value":"Bhor","label":"Bhor","data":{"state":"Maharashtra","id":"78940","stateid":"6489","flname":"bhor"}},{"value":"Bhota","label":"Bhota","data":{"state":"Himachal Pradesh","id":"98816","stateid":"6482","flname":"bhota"}},{"value":"Bhowali","label":"Bhowali","data":{"state":"Uttarakhand","id":"98817","stateid":"6500","flname":"bhowali"}},{"value":"Bhowrah","label":"Bhowrah","data":{"state":"Jharkhand","id":"98818","stateid":"6484","flname":"bhowrah"}}]

class CitySearchModel {
  CitySearchModel({
      List<City>? city,}){
    _city = city;
}

  CitySearchModel.fromJson(dynamic json) {
    if (json['city'] != null) {
      _city = [];
      json['city'].forEach((v) {
        _city?.add(City.fromJson(v));
      });
    }
  }
  List<City>? _city;
CitySearchModel copyWith({  List<City>? city,
}) => CitySearchModel(  city: city ?? _city,
);
  List<City>? get city => _city;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_city != null) {
      map['city'] = _city?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// value : "Bhopal"
/// label : "Bhopal"
/// data : {"state":"Madhya Pradesh","id":"70588","stateid":"6488","flname":"bhopal"}

class City {
  City({
      String? value, 
      String? label, 
      CityTypeList? data,}){
    _value = value;
    _label = label;
    _data = data;
}

  City.fromJson(dynamic json) {
    _value = json['value'];
    _label = json['label'];
    _data = json['data'] != null ? CityTypeList.fromJson(json['data']) : null;
  }
  String? _value;
  String? _label;
  CityTypeList? _data;
City copyWith({  String? value,
  String? label,
  CityTypeList? data,
}) => City(  value: value ?? _value,
  label: label ?? _label,
  data: data ?? _data,
);
  String? get value => _value;
  String? get label => _label;
  CityTypeList? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['value'] = _value;
    map['label'] = _label;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// state : "Madhya Pradesh"
/// id : "70588"
/// stateid : "6488"
/// flname : "bhopal"

class CityTypeList {
  CityTypeList({
      String? state, 
      String? id, 
      String? stateid, 
      String? flname,}){
    _state = state;
    _id = id;
    _stateid = stateid;
    _flname = flname;
}

  CityTypeList.fromJson(dynamic json) {
    _state = json['state'];
    _id = json['id'];
    _stateid = json['stateid'];
    _flname = json['flname'];
  }
  String? _state;
  String? _id;
  String? _stateid;
  String? _flname;
CityTypeList copyWith({  String? state,
  String? id,
  String? stateid,
  String? flname,
}) => CityTypeList(  state: state ?? _state,
  id: id ?? _id,
  stateid: stateid ?? _stateid,
  flname: flname ?? _flname,
);
  String? get state => _state;
  String? get id => _id;
  String? get stateid => _stateid;
  String? get flname => _flname;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['state'] = _state;
    map['id'] = _id;
    map['stateid'] = _stateid;
    map['flname'] = _flname;
    return map;
  }

}