/// error : false
/// message : "Faqs Get Sucessfully !"
/// data : [{"id":"2","question":"what is your name","answer":"my name is pradip kumar patel","status":"1"},{"id":"5","question":"how to use in business growth","answer":"you can contact with as per business profile like business men easily","status":"1"},{"id":"6","question":"any other facility","answer":"by this you can get map related business person contact","status":"1"}]

class GetFaqModel {
  GetFaqModel({
      bool? error, 
      String? message, 
      List<Data>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  GetFaqModel.fromJson(dynamic json) {
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
GetFaqModel copyWith({  bool? error,
  String? message,
  List<Data>? data,
}) => GetFaqModel(  error: error ?? _error,
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

/// id : "2"
/// question : "what is your name"
/// answer : "my name is pradip kumar patel"
/// status : "1"

class Data {
  Data({
      String? id, 
      String? question, 
      String? answer, 
      String? status,}){
    _id = id;
    _question = question;
    _answer = answer;
    _status = status;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _question = json['question'];
    _answer = json['answer'];
    _status = json['status'];
  }
  String? _id;
  String? _question;
  String? _answer;
  String? _status;
Data copyWith({  String? id,
  String? question,
  String? answer,
  String? status,
}) => Data(  id: id ?? _id,
  question: question ?? _question,
  answer: answer ?? _answer,
  status: status ?? _status,
);
  String? get id => _id;
  String? get question => _question;
  String? get answer => _answer;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['question'] = _question;
    map['answer'] = _answer;
    map['status'] = _status;
    return map;
  }

}