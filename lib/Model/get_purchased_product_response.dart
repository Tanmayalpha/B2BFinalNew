class GetPurchasedProductResponse {
  bool? error;
  String? message;
  List<PurchaesData>? purchaesData;

  GetPurchasedProductResponse({this.error, this.message, this.purchaesData});

  GetPurchasedProductResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    if (json['purchaes_data'] != null) {
      purchaesData = <PurchaesData>[];
      json['purchaes_data'].forEach((v) {
        purchaesData!.add(new PurchaesData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.purchaesData != null) {
      data['purchaes_data'] =
          this.purchaesData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PurchaesData {
  String? categoryId;
  String? subCategoryId;
  List<String>? products;

  PurchaesData({this.categoryId, this.subCategoryId, this.products});

  PurchaesData.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    products = json['products'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['products'] = this.products;
    return data;
  }
}
