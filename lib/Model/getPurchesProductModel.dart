// To parse this JSON data, do
//
//     final getPurchesProductModel = getPurchesProductModelFromJson(jsonString);

import 'dart:convert';

GetPurchesProductModel getPurchesProductModelFromJson(String str) => GetPurchesProductModel.fromJson(json.decode(str));

String getPurchesProductModelToJson(GetPurchesProductModel data) => json.encode(data.toJson());

class GetPurchesProductModel {
  bool error;
  String message;
  List<PurchaesDatum> purchaesData;

  GetPurchesProductModel({
    required this.error,
    required this.message,
    required this.purchaesData,
  });

  factory GetPurchesProductModel.fromJson(Map<String, dynamic> json) => GetPurchesProductModel(
    error: json["error"],
    message: json["message"],
    purchaesData: List<PurchaesDatum>.from(json["purchaes_data"].map((x) => PurchaesDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "purchaes_data": List<dynamic>.from(purchaesData.map((x) => x.toJson())),
  };
}

class PurchaesDatum {
  String id;
  String name;
  String categoryId;
  String subCategoryId;
  String userId;

  PurchaesDatum({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.subCategoryId,
    required this.userId,
  });

  factory PurchaesDatum.fromJson(Map<String, dynamic> json) => PurchaesDatum(
    id: json["id"],
    name: json["name"],
    categoryId: json["category_id"],
    subCategoryId: json["sub_category_id"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "category_id": categoryId,
    "sub_category_id": subCategoryId,
    "user_id": userId,
  };
}
