// To parse this JSON data, do
//
//     final userUpdatemodel = userUpdatemodelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UserUpdatemodel userUpdatemodelFromJson(String str) => UserUpdatemodel.fromJson(json.decode(str));

String userUpdatemodelToJson(UserUpdatemodel data) => json.encode(data.toJson());

class UserUpdatemodel {
  bool error;
  String message;
  List<Map<String, String>> data;

  UserUpdatemodel({
    required this.error,
    required this.message,
    required this.data,
  });

  factory UserUpdatemodel.fromJson(Map<String, dynamic> json) => UserUpdatemodel(
    error: json["error"],
    message: json["message"],
    data: List<Map<String, String>>.from(json["data"].map((x) => Map.from(x).map((k, v) => MapEntry<String, String>(k, v)))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
  };
}
