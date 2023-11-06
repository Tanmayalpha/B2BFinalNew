// To parse this JSON data, do
//
//     final advertiseModel = advertiseModelFromJson(jsonString);

import 'dart:convert';

AdvertiseModel advertiseModelFromJson(String str) => AdvertiseModel.fromJson(json.decode(str));

String advertiseModelToJson(AdvertiseModel data) => json.encode(data.toJson());

class AdvertiseModel {
  bool error;
  String message;
  List<Datum> data;

  AdvertiseModel({
    required this.error,
    required this.message,
    required this.data,
  });

  factory AdvertiseModel.fromJson(Map<String, dynamic> json) => AdvertiseModel(
    error: json["error"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String id;
  String image;
  DateTime createdAt;
  DateTime updatedAt;
  String categoryId;
  DateTime startDate;
  DateTime endDate;
  dynamic status;

  Datum({
    required this.id,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.categoryId,
    required this.startDate,
    required this.endDate,
    this.status,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    image: json["image"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    categoryId: json["category_id"],
    startDate: DateTime.parse(json["start_date"]),
    endDate: DateTime.parse(json["end_date"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "category_id": categoryId,
    "start_date": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
    "end_date": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
    "status": status,
  };
}
