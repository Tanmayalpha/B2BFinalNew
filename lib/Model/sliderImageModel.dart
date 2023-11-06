// To parse this JSON data, do
//
//     final sliderImageModel = sliderImageModelFromJson(jsonString);

import 'dart:convert';

SliderImageModel sliderImageModelFromJson(String str) => SliderImageModel.fromJson(json.decode(str));

String sliderImageModelToJson(SliderImageModel data) => json.encode(data.toJson());

class SliderImageModel {
  bool error;
  List<SliderImageData> data;

  SliderImageModel({
    required this.error,
    required this.data,
  });

  factory SliderImageModel.fromJson(Map<String, dynamic> json) => SliderImageModel(
    error: json["error"],
    data: List<SliderImageData>.from(json["data"].map((x) => SliderImageData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class SliderImageData {
  String id;
  String type;
  String typeId;
  String link;
  String image;
  DateTime dateAdded;
  List<dynamic> data;

  SliderImageData({
    required this.id,
    required this.type,
    required this.typeId,
    required this.link,
    required this.image,
    required this.dateAdded,
    required this.data,
  });

  factory SliderImageData.fromJson(Map<String, dynamic> json) => SliderImageData(
    id: json["id"],
    type: json["type"],
    typeId: json["type_id"],
    link: json["link"],
    image: json["image"],
    dateAdded: DateTime.parse(json["date_added"]),
    data: List<dynamic>.from(json["data"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "type_id": typeId,
    "link": link,
    "image": image,
    "date_added": dateAdded.toIso8601String(),
    "data": List<dynamic>.from(data.map((x) => x)),
  };
}
