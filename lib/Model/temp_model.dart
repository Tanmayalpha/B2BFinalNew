import 'AllProductModel.dart';

class TempModel {
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
  String? typeOfSeller;
  String? sellerId;
  String? sellerName;
  String? city;

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
  List<Null>? otherImages;
  String? videoType;
  String? video;
  List<String>? tags;
  String? taxNumber;
  String? subscriptionType;
  String? lat;
  String? lang;
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
  List<Null>? reviewImages;
  List<Null>? attributes;
  List<Variants>? variants;
  String? totalStock;
  MinMaxPrice? minMaxPrice;
  String? address;
  String? relativePath;
  List<Null>? otherImagesRelativePath;
  String? videoRelativePath;
  String? totalProduct;
  String? deliverableZipcodesIds;
  bool? isDeliverable;
  bool? isPurchased;
  String? isFavorite;
  String? imageMd;
  String? imageSm;
  List<Null>? otherImagesSm;
  List<Null>? otherImagesMd;
  List<Null>? variantAttributes;

  TempModel({this.total,
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
    this.typeOfSeller,
    this.sellerId,
    this.sellerName,
    this.sellerAddress,
    this.id,
    this.stock,
    this.name,
    this.categoryId,
    this.shortDescription,
    this.slug,
    this.city,
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
    this.otherImages,
    this.videoType,
    this.video,
    this.tags,
    this.taxNumber,
    this.subscriptionType,
    this.lat,
    this.lang,
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
    this.reviewImages,
    this.attributes,
    this.variants,
    this.totalStock,
    this.minMaxPrice,
    this.address,
    this.relativePath,
    this.otherImagesRelativePath,
    this.videoRelativePath,
    this.totalProduct,
    this.deliverableZipcodesIds,
    this.isDeliverable,
    this.isPurchased,
    this.isFavorite,
    this.imageMd,
    this.imageSm,
    this.otherImagesSm,
    this.otherImagesMd,
    this.variantAttributes});

  TempModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    sales = json['sales'];
    city= json['city'];
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
    typeOfSeller = json['type_of_seller'];
    sellerId = json['seller_id'];
    sellerName = json['seller_name'];
    sellerAddress = json['seller_address'];
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
    //minimumOrderQuantity = json['minimum_order_quantity'];
    sku = json['sku'];
   // quantityStepSize = json['quantity_step_size'];
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
    tags = json['tags'].cast<String>();
    taxNumber = json['tax_number'];
    subscriptionType = json['subscription_type'];
    lat = json['latitude'];
    lang = json['longitude'];
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
    /* if (json['review_images'] != null) {
      reviewImages = <Null>[];
      json['review_images'].forEach((v) {
        reviewImages!.add(new Null.fromJson(v));
      });
    }*/
    /*if (json['attributes'] != null) {
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
    address = json['address'];
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
    isFavorite = json['is_favorite'];
    imageMd = json['image_md'];
    imageSm = json['image_sm'];
    if (json['other_images_sm'] != null) {
      /*otherImagesSm = <Null>[];
      json['other_images_sm'].forEach((v) {
        otherImagesSm!.add(new Null.fromJson(v));
      });
    }
    if (json['other_images_md'] != null) {
      otherImagesMd = <Null>[];
      json['other_images_md'].forEach((v) {
        otherImagesMd!.add(new Null.fromJson(v));
      });
    }
    if (json['variant_attributes'] != null) {
      variantAttributes = <Null>[];
      json['variant_attributes'].forEach((v) {
        variantAttributes!.add(new Null.fromJson(v));
      });
    }*/
    }

    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['total'] = this.total;
      data['sales'] = this.sales;
      data['stock_type'] = this.stockType;
      data['is_prices_inclusive_tax'] = this.isPricesInclusiveTax;
      data['type'] = this.type;
      data['attr_value_ids'] = this.attrValueIds;
      data['seller_rating'] = this.sellerRating;
      data['seller_slug'] = this.sellerSlug;
      data['seller_no_of_ratings'] = this.sellerNoOfRatings;
      data['seller_profile'] = this.sellerProfile;
      data['store_name'] = this.storeName;
      data['store_description'] = this.storeDescription;
      data['type_of_seller'] = this.typeOfSeller;
      data['seller_id'] = this.sellerId;
      data['seller_name'] = this.sellerName;
      data['seller_address'] = this.sellerAddress;
      data['id'] = this.id;
      data['stock'] = this.stock;
      data['name'] = this.name;
      data['category_id'] = this.categoryId;
      data['short_description'] = this.shortDescription;
      data['slug'] = this.slug;
      data['description'] = this.description;
      data['extra_description'] = this.extraDescription;
      data['total_allowed_quantity'] = this.totalAllowedQuantity;
      data['status'] = this.status;
      data['deliverable_type'] = this.deliverableType;
      data['deliverable_zipcodes'] = this.deliverableZipcodes;
      data['minimum_order_quantity'] = this.minimumOrderQuantity;
      data['sku'] = this.sku;
      data['quantity_step_size'] = this.quantityStepSize;
      data['cod_allowed'] = this.codAllowed;
      data['row_order'] = this.rowOrder;
      data['rating'] = this.rating;
      data['no_of_ratings'] = this.noOfRatings;
      data['image'] = this.image;
      data['is_returnable'] = this.isReturnable;
      data['is_cancelable'] = this.isCancelable;
      data['cancelable_till'] = this.cancelableTill;
      data['indicator'] = this.indicator;
      /*if (this.otherImages != null) {
      data['other_images'] = this.otherImages!.map((v) => v.toJson()).toList();
    }*/
      data['video_type'] = this.videoType;
      data['video'] = this.video;
      data['tags'] = this.tags;
      data['tax_number'] = this.taxNumber;
      data['subscription_type'] = this.subscriptionType;
      data['warranty_period'] = this.warrantyPeriod;
      data['guarantee_period'] = this.guaranteePeriod;
      data['made_in'] = this.madeIn;
      data['hsn_code'] = this.hsnCode;
      data['download_allowed'] = this.downloadAllowed;
      data['download_type'] = this.downloadType;
      data['download_link'] = this.downloadLink;
      data['pickup_location'] = this.pickupLocation;
      data['brand'] = this.brand;
      data['availability'] = this.availability;
      data['category_name'] = this.categoryName;
      data['tax_percentage'] = this.taxPercentage;
      data['tax_id'] = this.taxId;
      data['broucher_image'] = this.broucherImage;
      /* if (this.reviewImages != null) {
      data['review_images'] =
          this.reviewImages!.map((v) => v.toJson()).toList();
    }
    if (this.attributes != null) {
      data['attributes'] = this.attributes!.map((v) => v.toJson()).toList();
    }*/
      if (this.variants != null) {
        data['variants'] = this.variants!.map((v) => v.toJson()).toList();
      }
      data['total_stock'] = this.totalStock;
      if (this.minMaxPrice != null) {
        data['min_max_price'] = this.minMaxPrice!.toJson();
      }
      data['address'] = this.address;
      data['relative_path'] = this.relativePath;
      /*if (this.otherImagesRelativePath != null) {
      data['other_images_relative_path'] =
          this.otherImagesRelativePath!.map((v) => v.toJson()).toList();
    }*/
      data['video_relative_path'] = this.videoRelativePath;
      data['total_product'] = this.totalProduct;
      data['deliverable_zipcodes_ids'] = this.deliverableZipcodesIds;
      data['is_deliverable'] = this.isDeliverable;
      data['is_purchased'] = this.isPurchased;
      data['is_favorite'] = this.isFavorite;
      data['image_md'] = this.imageMd;
      data['image_sm'] = this.imageSm;
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
    data['min_price'] = this.minPrice;
    data['max_price'] = this.maxPrice;
    data['special_price'] = this.specialPrice;
    data['max_special_price'] = this.maxSpecialPrice;
    data['discount_in_percentage'] = this.discountInPercentage;
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
  List<Null>? images;
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
  this.images,
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
  //  this.imagesMd,
  // this.imagesSm,
  //  this.variantRelativePath,
  this.cartCount});

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
  /*if (json['images'] != null) {
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
    }
    if (json['images_sm'] != null) {
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
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = this.id;
  data['product_id'] = this.productId;
  data['attribute_value_ids'] = this.attributeValueIds;
  data['attribute_set'] = this.attributeSet;
  data['price'] = this.price;
  data['special_price'] = this.specialPrice;
  data['sku'] = this.sku;
  data['stock'] = this.stock;
  data['weight'] = this.weight;
  data['height'] = this.height;
  data['breadth'] = this.breadth;
  data['length'] = this.length;
  /*if (this.images != null) {
  data['images'] = this.images!.map((v) => v.toJson()).toList();
  }*/
  data['availability'] = this.availability;
  data['status'] = this.status;
  data['date_added'] = this.dateAdded;
  data['color'] = this.color;
  data['packete'] = this.packete;
  data['variant_ids'] = this.variantIds;
  data['attr_name'] = this.attrName;
  data['variant_values'] = this.variantValues;
  data['swatche_type'] = this.swatcheType;
  data['swatche_value'] = this.swatcheValue;
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
  data['cart_count'] = this.cartCount;
  return data;
  }
  }


  class TempMode2 {

    List<TempModel> ? temp ;
    String? catName ;

    TempMode2({this.temp, this.catName}) ;

  }
