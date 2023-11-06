class GetSupplierOrClientResponse {
  bool? error;
  String? message;
  //List<Null>? filters;
  String? total;
  String? offset;
//  SupplierOrClientData? data;
  List<ClientSupplierProductData>? product;


  GetSupplierOrClientResponse(
      {this.error,
        this.message,
        //this.filters,
        this.total,
        this.offset,
        this.product});

  GetSupplierOrClientResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    /*if (json['filters'] != null) {
      filters = <Null>[];
      json['filters'].forEach((v) {
        filters!.add(new Null.fromJson(v));
      });
    }*/
    total = json['total'];
    offset = json['offset'];
    if (json['data'] != null) {
      product = <ClientSupplierProductData>[];
      json['data'].forEach((v) {
        product!.add(ClientSupplierProductData.fromJson(v));
      });
    }
    //data = json['data'] != null ? SupplierOrClientData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    data['message'] = message;
    /*if (this.filters != null) {
      data['filters'] = this.filters!.map((v) => v.toJson()).toList();
    }*/
    data['total'] = total;
    data['offset'] = offset;
    if (product != null) {
      data['data'] = product!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SupplierOrClientData {
  String? total;
  String? minPrice;
  String? maxPrice;
  List<ClientSupplierProductData>? product;
  //List<Null>? filters;

  SupplierOrClientData({this.total, this.minPrice, this.maxPrice, this.product, /*this.filters*/});

  SupplierOrClientData.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    minPrice = json['min_price'];
    maxPrice = json['max_price'];
    if (json['product'] != null) {
      product = <ClientSupplierProductData>[];
      json['product'].forEach((v) {
        product!.add(new ClientSupplierProductData.fromJson(v));
      });
    }
    /*if (json['filters'] != null) {
      filters = <Null>[];
      json['filters'].forEach((v) {
        filters!.add(new Null.fromJson(v));
      });
    }*/
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['min_price'] = minPrice;
    data['max_price'] = maxPrice;
    if (product != null) {
      data['product'] = product!.map((v) => v.toJson()).toList();
    }
    /*if (this.filters != null) {
      data['filters'] = this.filters!.map((v) => v.toJson()).toList();
    }*/
    return data;
  }
}

class ClientSupplierProductData {
  String? total;
  String? sales;
  String? stockType;
  String? isPricesInclusiveTax;
  String? type;
  String? attrValueIds;
  String? sellerRating;
  String? sellerSlug;
  String? sellerNoOfRatings;
  String? sellerProfile;
  String? storeName;
  String? storeDescription;
  String? sellerId;
  String? sellerName;
  String? sellerAddress;
  String? id;
  String? stock;
  String? name;
  String? categoryId;
  String? shortDescription;
  String? slug;
  String? description;
  String? extraDescription;
  String? totalAllowedQuantity;
  String? status;
  String? deliverableType;
  String? deliverableZipcodes;
  String? minimumOrderQuantity;
  String? sku;
  String? quantityStepSize;
  String? codAllowed;
  String? rowOrder;
  String? rating;
  String? noOfRatings;
  String? image;
  String? isReturnable;
  String? isCancelable;
  String? cancelableTill;
  String? indicator;
 // List<Null>? otherImages;
  String? videoType;
  String? video;
 // List<Null>? tags;
  String? warrantyPeriod;
  String? guaranteePeriod;
  String? madeIn;
  String? hsnCode;
  String? downloadAllowed;
  String? downloadType;
  String? downloadLink;
  String? pickupLocation;
  String? brand;
  String? availability;
  String? categoryName;
  String? taxPercentage;
  String? taxId;
  String? broucherImage;
 // List<Null>? reviewImages;
 // List<Null>? attributes;
  List<Variants>? variants;
  String? totalStock;
  MinMaxPrice? minMaxPrice;
  String? relativePath;
  //List<Null>? otherImagesRelativePath;
  String? videoRelativePath;
  String? totalProduct;
  String? deliverableZipcodesIds;
  bool? isDeliverable;
  bool? isPurchased;
  String? isFavorite;
  String? imageMd;
  String? imageSm;
 // List<Null>? otherImagesSm;
//  List<Null>? otherImagesMd;
 // List<Null>? variantAttributes;

  ClientSupplierProductData(
      {this.total,
        this.sales,
        this.stockType,
        this.isPricesInclusiveTax,
        this.type,
        this.attrValueIds,
        this.sellerRating,
        this.sellerSlug,
        this.sellerNoOfRatings,
        this.sellerProfile,
        this.storeName,
        this.storeDescription,
        this.sellerId,
        this.sellerName,
        this.sellerAddress,
        this.id,
        this.stock,
        this.name,
        this.categoryId,
        this.shortDescription,
        this.slug,
        this.description,
        this.extraDescription,
        this.totalAllowedQuantity,
        this.status,
        this.deliverableType,
        this.deliverableZipcodes,
        this.minimumOrderQuantity,
        this.sku,
        this.quantityStepSize,
        this.codAllowed,
        this.rowOrder,
        this.rating,
        this.noOfRatings,
        this.image,
        this.isReturnable,
        this.isCancelable,
        this.cancelableTill,
        this.indicator,
      //  this.otherImages,
        this.videoType,
        this.video,
        //this.tags,
        this.warrantyPeriod,
        this.guaranteePeriod,
        this.madeIn,
        this.hsnCode,
        this.downloadAllowed,
        this.downloadType,
        this.downloadLink,
        this.pickupLocation,
        this.brand,
        this.availability,
        this.categoryName,
        this.taxPercentage,
        this.taxId,
        this.broucherImage,
        //this.reviewImages,
        //this.attributes,
        this.variants,
        this.totalStock,
        this.minMaxPrice,
        this.relativePath,
        //this.otherImagesRelativePath,
        this.videoRelativePath,
        this.totalProduct,
        this.deliverableZipcodesIds,
        this.isDeliverable,
        this.isPurchased,
        this.isFavorite,
        this.imageMd,
        this.imageSm,
        //this.otherImagesSm,
        //this.otherImagesMd,
        //this.variantAttributes
      });

  ClientSupplierProductData.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    sales = json['sales'];
    stockType = json['stock_type'];
    isPricesInclusiveTax = json['is_prices_inclusive_tax'];
    type = json['type'];
    attrValueIds = json['attr_value_ids'];
    sellerRating = json['seller_rating'];
    sellerSlug = json['seller_slug'];
    sellerNoOfRatings = json['seller_no_of_ratings'];
    sellerProfile = json['seller_profile'];
    storeName = json['store_name'];
    storeDescription = json['store_description'];
    sellerId = json['seller_id'];
    sellerName = json['seller_name'];
    sellerAddress = json['address'];
    id = json['id'];
    stock = json['stock'];
    name = json['name'];
    categoryId = json['category_id'];
    shortDescription = json['short_description'];
    slug = json['slug'];
    description = json['description'];
    extraDescription = json['extra_description'];
    totalAllowedQuantity = json['total_allowed_quantity'];
    status = json['status'];
    deliverableType = json['deliverable_type'];
    deliverableZipcodes = json['deliverable_zipcodes'];
    minimumOrderQuantity = json['minimum_order_quantity'];
    sku = json['sku'];
    quantityStepSize = json['quantity_step_size'];
    codAllowed = json['cod_allowed'];
    rowOrder = json['row_order'];
    rating = json['rating'];
    noOfRatings = json['no_of_ratings'];
    image = json['image'];
    isReturnable = json['is_returnable'];
    isCancelable = json['is_cancelable'];
    cancelableTill = json['cancelable_till'];
    indicator = json['indicator'];
    /*if (json['other_images'] != null) {
      otherImages = <Null>[];
      json['other_images'].forEach((v) {
        otherImages!.add(new Null.fromJson(v));
      });
    }*/
    videoType = json['video_type'];
    video = json['video'];
    /*if (json['tags'] != null) {
      tags = <Null>[];
      json['tags'].forEach((v) {
        tags!.add(new Null.fromJson(v));
      });
    }*/
    warrantyPeriod = json['warranty_period'];
    guaranteePeriod = json['guarantee_period'];
    madeIn = json['made_in'];
    hsnCode = json['hsn_code'];
    downloadAllowed = json['download_allowed'];
    downloadType = json['download_type'];
    downloadLink = json['download_link'];
    pickupLocation = json['pickup_location'];
    brand = json['brand'];
    availability = json['availability'];
    categoryName = json['category_name'];
    taxPercentage = json['tax_percentage'];
    taxId = json['tax_id'];
    broucherImage = json['broucher_image'];
    /*if (json['review_images'] != null) {
      reviewImages = <Null>[];
      json['review_images'].forEach((v) {
        reviewImages!.add(new Null.fromJson(v));
      });
    }
    if (json['attributes'] != null) {
      attributes = <Null>[];
      json['attributes'].forEach((v) {
        attributes!.add(new Null.fromJson(v));
      });
    }*/
    if (json['variants'] != null) {
      variants = <Variants>[];
      json['variants'].forEach((v) {
        variants!.add(new Variants.fromJson(v));
      });
    }
    totalStock = json['total_stock'];
    minMaxPrice = json['min_max_price'] != null
        ? new MinMaxPrice.fromJson(json['min_max_price'])
        : null;
    relativePath = json['relative_path'];
    /*if (json['other_images_relative_path'] != null) {
      otherImagesRelativePath = <Null>[];
      json['other_images_relative_path'].forEach((v) {
        otherImagesRelativePath!.add(new Null.fromJson(v));
      });
    }*/
    videoRelativePath = json['video_relative_path'];
    totalProduct = json['total_product'];
    deliverableZipcodesIds = json['deliverable_zipcodes_ids'];
    isDeliverable = json['is_deliverable'];
    isPurchased = json['is_purchased'];
    isFavorite = json['is_favorite'].toString();
    imageMd = json['image_md'];
    imageSm = json['image_sm'];
    /*if (json['other_images_sm'] != null) {
      otherImagesSm = <Null>[];
      json['other_images_sm'].forEach((v) {
        otherImagesSm!.add(new Null.fromJson(v));
      });
    }*/
    /*if (json['other_images_md'] != null) {
      otherImagesMd = <Null>[];
      json['other_images_md'].forEach((v) {
        otherImagesMd!.add(new Null.fromJson(v));
      });
    }*/
    /*if (json['variant_attributes'] != null) {
      variantAttributes = <Null>[];
      json['variant_attributes'].forEach((v) {
        variantAttributes!.add(new Null.fromJson(v));
      });
    }*/
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = total;
    data['sales'] = sales;
    data['stock_type'] = stockType;
    data['is_prices_inclusive_tax'] = isPricesInclusiveTax;
    data['type'] = type;
    data['attr_value_ids'] = attrValueIds;
    data['seller_rating'] = sellerRating;
    data['seller_slug'] = sellerSlug;
    data['seller_no_of_ratings'] = sellerNoOfRatings;
    data['seller_profile'] = sellerProfile;
    data['store_name'] = storeName;
    data['store_description'] = storeDescription;
    data['seller_id'] = sellerId;
    data['seller_name'] = sellerName;
    data['address'] = sellerAddress;
    data['id'] = id;
    data['stock'] = stock;
    data['name'] = name;
    data['category_id'] = categoryId;
    data['short_description'] = shortDescription;
    data['slug'] = slug;
    data['description'] = description;
    data['extra_description'] = extraDescription;
    data['total_allowed_quantity'] = totalAllowedQuantity;
    data['status'] = status;
    data['deliverable_type'] = deliverableType;
    data['deliverable_zipcodes'] = deliverableZipcodes;
    data['minimum_order_quantity'] = minimumOrderQuantity;
    data['sku'] = sku;
    data['quantity_step_size'] = quantityStepSize;
    data['cod_allowed'] = codAllowed;
    data['row_order'] = rowOrder;
    data['rating'] = rating;
    data['no_of_ratings'] = noOfRatings;
    data['image'] = image;
    data['is_returnable'] = isReturnable;
    data['is_cancelable'] = isCancelable;
    data['cancelable_till'] = cancelableTill;
    data['indicator'] = indicator;
    /*if (this.otherImages != null) {
      data['other_images'] = this.otherImages!.map((v) => v.toJson()).toList();
    }*/
    data['video_type'] = videoType;
    data['video'] = video;
    /*if (this.tags != null) {
      data['tags'] = this.tags!.map((v) => v.toJson()).toList();
    }*/
    data['warranty_period'] = warrantyPeriod;
    data['guarantee_period'] = guaranteePeriod;
    data['made_in'] = madeIn;
    data['hsn_code'] = hsnCode;
    data['download_allowed'] = downloadAllowed;
    data['download_type'] = downloadType;
    data['download_link'] = downloadLink;
    data['pickup_location'] = pickupLocation;
    data['brand'] = brand;
    data['availability'] = availability;
    data['category_name'] = categoryName;
    data['tax_percentage'] = taxPercentage;
    data['tax_id'] = taxId;
    data['broucher_image'] = broucherImage;
    /*if (this.reviewImages != null) {
      data['review_images'] =
          this.reviewImages!.map((v) => v.toJson()).toList();
    }
    if (this.attributes != null) {
      data['attributes'] = this.attributes!.map((v) => v.toJson()).toList();
    }*/
    if (variants != null) {
      data['variants'] = variants!.map((v) => v.toJson()).toList();
    }
    data['total_stock'] = totalStock;
    if (minMaxPrice != null) {
      data['min_max_price'] = minMaxPrice!.toJson();
    }
    data['relative_path'] = relativePath;
    /*if (this.otherImagesRelativePath != null) {
      data['other_images_relative_path'] =
          this.otherImagesRelativePath!.map((v) => v.toJson()).toList();
    }*/
    data['video_relative_path'] = videoRelativePath;
    data['total_product'] = totalProduct;
    data['deliverable_zipcodes_ids'] = deliverableZipcodesIds;
    data['is_deliverable'] = isDeliverable;
    data['is_purchased'] = isPurchased;
    data['is_favorite'] = isFavorite;
    data['image_md'] = imageMd;
    data['image_sm'] = imageSm;
    /*if (this.otherImagesSm != null) {
      data['other_images_sm'] =
          this.otherImagesSm!.map((v) => v.toJson()).toList();
    }
    if (this.otherImagesMd != null) {
      data['other_images_md'] =
          this.otherImagesMd!.map((v) => v.toJson()).toList();
    }
    if (this.variantAttributes != null) {
      data['variant_attributes'] =
          this.variantAttributes!.map((v) => v.toJson()).toList();
    }*/
    return data;
  }
}

class Variants {
  String? id;
  String? productId;
  String? attributeValueIds;
  String? attributeSet;
  String? price;
  String? specialPrice;
  String? sku;
  String? stock;
  String? weight;
  String? height;
  String? breadth;
  String? length;
 // List<Null>? images;
  String? availability;
  String? status;
  String? dateAdded;
  String? color;
  String? packete;
  String? variantIds;
  String? attrName;
  String? variantValues;
  String? swatcheType;
  String? swatcheValue;
 // List<Null>? imagesMd;
 // List<Null>? imagesSm;
//  List<Null>? variantRelativePath;
  String? cartCount;
  int? isPurchased;

  Variants(
      {this.id,
        this.productId,
        this.attributeValueIds,
        this.attributeSet,
        this.price,
        this.specialPrice,
        this.sku,
        this.stock,
        this.weight,
        this.height,
        this.breadth,
        this.length,
        //this.images,
        this.availability,
        this.status,
        this.dateAdded,
        this.color,
        this.packete,
        this.variantIds,
        this.attrName,
        this.variantValues,
        this.swatcheType,
        this.swatcheValue,
        /*this.imagesMd,
        this.imagesSm,
        this.variantRelativePath,*/
        this.cartCount,
        this.isPurchased});

  Variants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    attributeValueIds = json['attribute_value_ids'];
    attributeSet = json['attribute_set'];
    price = json['price'];
    specialPrice = json['special_price'];
    sku = json['sku'];
    stock = json['stock'];
    weight = json['weight'];
    height = json['height'];
    breadth = json['breadth'];
    length = json['length'];
   /* if (json['images'] != null) {
      images = <Null>[];
      json['images'].forEach((v) {
        images!.add(new Null.fromJson(v));
      });
    }*/
    availability = json['availability'];
    status = json['status'];
    dateAdded = json['date_added'];
    color = json['color'];
    packete = json['packete'];
    variantIds = json['variant_ids'];
    attrName = json['attr_name'];
    variantValues = json['variant_values'];
    swatcheType = json['swatche_type'];
    swatcheValue = json['swatche_value'];
    /*if (json['images_md'] != null) {
      imagesMd = <Null>[];
      json['images_md'].forEach((v) {
        imagesMd!.add(new Null.fromJson(v));
      });
    }*/
    /*if (json['images_sm'] != null) {
      imagesSm = <Null>[];
      json['images_sm'].forEach((v) {
        imagesSm!.add(new Null.fromJson(v));
      });
    }
    if (json['variant_relative_path'] != null) {
      variantRelativePath = <Null>[];
      json['variant_relative_path'].forEach((v) {
        variantRelativePath!.add(new Null.fromJson(v));
      });
    }*/
    cartCount = json['cart_count'];
    isPurchased = json['is_purchased'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['attribute_value_ids'] = attributeValueIds;
    data['attribute_set'] = attributeSet;
    data['price'] = price;
    data['special_price'] = specialPrice;
    data['sku'] = sku;
    data['stock'] = stock;
    data['weight'] = weight;
    data['height'] = height;
    data['breadth'] = breadth;
    data['length'] = length;
    /*if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }*/
    data['availability'] = availability;
    data['status'] = status;
    data['date_added'] = dateAdded;
    data['color'] = color;
    data['packete'] = packete;
    data['variant_ids'] = variantIds;
    data['attr_name'] = attrName;
    data['variant_values'] = variantValues;
    data['swatche_type'] = swatcheType;
    data['swatche_value'] = swatcheValue;
    /*if (this.imagesMd != null) {
      data['images_md'] = this.imagesMd!.map((v) => v.toJson()).toList();
    }
    if (this.imagesSm != null) {
      data['images_sm'] = this.imagesSm!.map((v) => v.toJson()).toList();
    }
    if (this.variantRelativePath != null) {
      data['variant_relative_path'] =
          this.variantRelativePath!.map((v) => v.toJson()).toList();
    }*/
    data['cart_count'] = cartCount;
    data['is_purchased'] = isPurchased;
    return data;
  }
}

class MinMaxPrice {
  int? minPrice;
  int? maxPrice;
  int? specialPrice;
  int? maxSpecialPrice;
  int? discountInPercentage;

  MinMaxPrice(
      {this.minPrice,
        this.maxPrice,
        this.specialPrice,
        this.maxSpecialPrice,
        this.discountInPercentage});

  MinMaxPrice.fromJson(Map<String, dynamic> json) {
    minPrice = json['min_price'];
    maxPrice = json['max_price'];
    specialPrice = json['special_price'];
    maxSpecialPrice = json['max_special_price'];
    discountInPercentage = json['discount_in_percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['min_price'] = minPrice;
    data['max_price'] = maxPrice;
    data['special_price'] = specialPrice;
    data['max_special_price'] = maxSpecialPrice;
    data['discount_in_percentage'] = discountInPercentage;
    return data;
  }
}
