// /// error : false
// /// message : "Products retrieved successfully !"
// /// min_price : "2"
// /// max_price : "5000"
// /// search : ""
// /// filters : [{"attribute_values":"clothes winter","attribute_values_id":"1","name":"test","swatche_type":"2","swatche_value":"httpS://developmentalphawizz.com/B2B/uploads/media/2023/thumb-sm/Antsnest.jpeg"}]
// /// tags : ["tag"]
// /// total : "1"
// /// offset : "0"
// /// subcategories : []
// /// data : [{"total":"25","sales":"59","stock_type":null,"is_prices_inclusive_tax":"0","type":"simple_product","attr_value_ids":"1","seller_rating":"0.0","seller_slug":null,"seller_no_of_ratings":"0","seller_profile":"httpS://developmentalphawizz.com/B2B/","store_name":"Textual Enterprises","store_description":"","seller_id":"549","seller_name":"Lalit bhai","id":"277","stock":null,"name":"surendra","category_id":"1","short_description":"demo","slug":"surendra","description":"","total_allowed_quantity":"100","deliverable_type":"1","deliverable_zipcodes":null,"minimum_order_quantity":"12","quantity_step_size":"1","cod_allowed":"1","row_order":"0","rating":"0","no_of_ratings":"0","image":"httpS://developmentalphawizz.com/B2B/assets/no-image.png","is_returnable":"0","is_cancelable":"0","cancelable_till":"","indicator":"1","other_images":["httpS://developmentalphawizz.com/B2B/assets/no-image.png","httpS://developmentalphawizz.com/B2B/assets/no-image.png"],"video_type":"","video":"","tags":["tag"],"warranty_period":"1 month","attribute_title":"d","attribute_value":"d","guarantee_period":"1 month","made_in":"ind","availability":null,"category_name":"Metal","sub_cat_name":"Metal","tax_percentage":"0","review_images":[],"attributes":[{"ids":"1","value":" clothes winter","attr_name":"test","name":"test","swatche_type":"2","swatche_value":"httpS://developmentalphawizz.com/B2B/uploads/media/2023/thumb-sm/Antsnest.jpeg"}],"variants":[{"id":"228","product_id":"277","attribute_value_ids":"","attribute_set":"","price":"4","special_price":"2","sku":"","stock":null,"weight":"0","height":"0","breadth":"0","length":"0","images":[],"availability":"","status":"1","date_added":"2023-10-17 13:14:40","color":"","packete":"","variant_ids":"","attr_name":"","variant_values":"","swatche_type":"","swatche_value":"","images_md":[],"images_sm":[],"cart_count":"0"}],"min_max_price":{"min_price":4,"max_price":4,"special_price":2,"max_special_price":2,"discount_in_percentage":50},"deliverable_zipcodes_ids":null,"is_deliverable":false,"is_purchased":false,"is_favorite":"0","image_md":"httpS://developmentalphawizz.com/B2B/assets/no-image.png","image_sm":"httpS://developmentalphawizz.com/B2B/assets/no-image.png","other_images_md":["httpS://developmentalphawizz.com/B2B/assets/no-image.png","httpS://developmentalphawizz.com/B2B/assets/no-image.png"],"other_images_sm":["httpS://developmentalphawizz.com/B2B/assets/no-image.png","httpS://developmentalphawizz.com/B2B/assets/no-image.png"],"variant_attributes":[]}]
//
// class ProductUpdateModel {
//   ProductUpdateModel({
//       bool? error,
//       String? message,
//       String? minPrice,
//       String? maxPrice,
//       String? search,
//       List<Filters>? filters,
//       List<String>? tags,
//       String? total,
//       String? offset,
//       List<dynamic>? subcategories,
//       List<Data>? data,}){
//     _error = error;
//     _message = message;
//     _minPrice = minPrice;
//     _maxPrice = maxPrice;
//     _search = search;
//     _filters = filters;
//     _tags = tags;
//     _total = total;
//     _offset = offset;
//     _subcategories = subcategories;
//     _data = data;
// }
//
//   ProductUpdateModel.fromJson(dynamic json) {
//     _error = json['error'];
//     _message = json['message'];
//     _minPrice = json['min_price'];
//     _maxPrice = json['max_price'];
//     _search = json['search'];
//     if (json['filters'] != null) {
//       _filters = [];
//       json['filters'].forEach((v) {
//         _filters?.add(Filters.fromJson(v));
//       });
//     }
//     _tags = json['tags'] != null ? json['tags'].cast<String>() : [];
//     _total = json['total'];
//     _offset = json['offset'];
//     if (json['subcategories'] != null) {
//       _subcategories = [];
//       json['subcategories'].forEach((v) {
//         _subcategories?.add(v.fromJson(v));
//       });
//     }
//     if (json['data'] != null) {
//       _data = [];
//       json['data'].forEach((v) {
//         _data?.add(Data.fromJson(v));
//       });
//     }
//   }
//   bool? _error;
//   String? _message;
//   String? _minPrice;
//   String? _maxPrice;
//   String? _search;
//   List<Filters>? _filters;
//   List<String>? _tags;
//   String? _total;
//   String? _offset;
//   List<dynamic>? _subcategories;
//   List<Data>? _data;
// ProductUpdateModel copyWith({  bool? error,
//   String? message,
//   String? minPrice,
//   String? maxPrice,
//   String? search,
//   List<Filters>? filters,
//   List<String>? tags,
//   String? total,
//   String? offset,
//   List<dynamic>? subcategories,
//   List<Data>? data,
// }) => ProductUpdateModel(  error: error ?? _error,
//   message: message ?? _message,
//   minPrice: minPrice ?? _minPrice,
//   maxPrice: maxPrice ?? _maxPrice,
//   search: search ?? _search,
//   filters: filters ?? _filters,
//   tags: tags ?? _tags,
//   total: total ?? _total,
//   offset: offset ?? _offset,
//   subcategories: subcategories ?? _subcategories,
//   data: data ?? _data,
// );
//   bool? get error => _error;
//   String? get message => _message;
//   String? get minPrice => _minPrice;
//   String? get maxPrice => _maxPrice;
//   String? get search => _search;
//   List<Filters>? get filters => _filters;
//   List<String>? get tags => _tags;
//   String? get total => _total;
//   String? get offset => _offset;
//   List<dynamic>? get subcategories => _subcategories;
//   List<Data>? get data => _data;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['error'] = _error;
//     map['message'] = _message;
//     map['min_price'] = _minPrice;
//     map['max_price'] = _maxPrice;
//     map['search'] = _search;
//     if (_filters != null) {
//       map['filters'] = _filters?.map((v) => v.toJson()).toList();
//     }
//     map['tags'] = _tags;
//     map['total'] = _total;
//     map['offset'] = _offset;
//     if (_subcategories != null) {
//       map['subcategories'] = _subcategories?.map((v) => v.toJson()).toList();
//     }
//     if (_data != null) {
//       map['data'] = _data?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
//
// }
//
// /// total : "25"
// /// sales : "59"
// /// stock_type : null
// /// is_prices_inclusive_tax : "0"
// /// type : "simple_product"
// /// attr_value_ids : "1"
// /// seller_rating : "0.0"
// /// seller_slug : null
// /// seller_no_of_ratings : "0"
// /// seller_profile : "httpS://developmentalphawizz.com/B2B/"
// /// store_name : "Textual Enterprises"
// /// store_description : ""
// /// seller_id : "549"
// /// seller_name : "Lalit bhai"
// /// id : "277"
// /// stock : null
// /// name : "surendra"
// /// category_id : "1"
// /// short_description : "demo"
// /// slug : "surendra"
// /// description : ""
// /// total_allowed_quantity : "100"
// /// deliverable_type : "1"
// /// deliverable_zipcodes : null
// /// minimum_order_quantity : "12"
// /// quantity_step_size : "1"
// /// cod_allowed : "1"
// /// row_order : "0"
// /// rating : "0"
// /// no_of_ratings : "0"
// /// image : "httpS://developmentalphawizz.com/B2B/assets/no-image.png"
// /// is_returnable : "0"
// /// is_cancelable : "0"
// /// cancelable_till : ""
// /// indicator : "1"
// /// other_images : ["httpS://developmentalphawizz.com/B2B/assets/no-image.png","httpS://developmentalphawizz.com/B2B/assets/no-image.png"]
// /// video_type : ""
// /// video : ""
// /// tags : ["tag"]
// /// warranty_period : "1 month"
// /// attribute_title : "d"
// /// attribute_value : "d"
// /// guarantee_period : "1 month"
// /// made_in : "ind"
// /// availability : null
// /// category_name : "Metal"
// /// sub_cat_name : "Metal"
// /// tax_percentage : "0"
// /// review_images : []
// /// attributes : [{"ids":"1","value":" clothes winter","attr_name":"test","name":"test","swatche_type":"2","swatche_value":"httpS://developmentalphawizz.com/B2B/uploads/media/2023/thumb-sm/Antsnest.jpeg"}]
// /// variants : [{"id":"228","product_id":"277","attribute_value_ids":"","attribute_set":"","price":"4","special_price":"2","sku":"","stock":null,"weight":"0","height":"0","breadth":"0","length":"0","images":[],"availability":"","status":"1","date_added":"2023-10-17 13:14:40","color":"","packete":"","variant_ids":"","attr_name":"","variant_values":"","swatche_type":"","swatche_value":"","images_md":[],"images_sm":[],"cart_count":"0"}]
// /// min_max_price : {"min_price":4,"max_price":4,"special_price":2,"max_special_price":2,"discount_in_percentage":50}
// /// deliverable_zipcodes_ids : null
// /// is_deliverable : false
// /// is_purchased : false
// /// is_favorite : "0"
// /// image_md : "httpS://developmentalphawizz.com/B2B/assets/no-image.png"
// /// image_sm : "httpS://developmentalphawizz.com/B2B/assets/no-image.png"
// /// other_images_md : ["httpS://developmentalphawizz.com/B2B/assets/no-image.png","httpS://developmentalphawizz.com/B2B/assets/no-image.png"]
// /// other_images_sm : ["httpS://developmentalphawizz.com/B2B/assets/no-image.png","httpS://developmentalphawizz.com/B2B/assets/no-image.png"]
// /// variant_attributes : []
//
// class Data {
//   Data({
//       String? total,
//       String? sales,
//       dynamic stockType,
//       String? isPricesInclusiveTax,
//       String? type,
//       String? attrValueIds,
//       String? sellerRating,
//        String? brand,
//       dynamic sellerSlug,
//       String? sellerNoOfRatings,
//       String? sellerProfile,
//       String? storeName,
//       String? storeDescription,
//       String? extraDescription,
//       String? sellerId,
//       String? sellerName,
//       String? id,
//       dynamic stock,
//       String? name,
//       String? categoryId,
//       String? shortDescription,
//       String? slug,
//       String? description,
//       String? totalAllowedQuantity,
//       String? deliverableType,
//       dynamic deliverableZipcodes,
//       String? minimumOrderQuantity,
//       String? quantityStepSize,
//       String? codAllowed,
//       String? rowOrder,
//       String? rating,
//       String? noOfRatings,
//       String? image,
//       String? isReturnable,
//       String? isCancelable,
//       String? cancelableTill,
//       String? indicator,
//       List<String>? otherImages,
//       String? videoType,
//       String? video,
//       List<String>? tags,
//       String? warrantyPeriod,
//       String? attributeTitle,
//       String? attributeValue,
//       String? guaranteePeriod,
//       String? madeIn,
//       dynamic availability,
//       String? categoryName,
//       String? subCatName,
//       String? taxPercentage,
//       List<dynamic>? reviewImages,
//       List<Attributes>? attributes,
//       List<Variants>? variants,
//       MinMaxPrice? minMaxPrice,
//       dynamic deliverableZipcodesIds,
//       bool? isDeliverable,
//       bool? isPurchased,
//       String? isFavorite,
//       String? imageMd,
//       String? imageSm,
//       List<String>? otherImagesMd,
//       List<String>? otherImagesSm,
//       List<dynamic>? variantAttributes,}){
//     _total = total;
//     _sales = sales;
//     _stockType = stockType;
//     _isPricesInclusiveTax = isPricesInclusiveTax;
//     _type = type;
//     _attrValueIds = attrValueIds;
//     _sellerRating = sellerRating;
//     _sellerSlug = sellerSlug;
//     _sellerNoOfRatings = sellerNoOfRatings;
//     _sellerProfile = sellerProfile;
//     _storeName = storeName;
//     _storeDescription = storeDescription;
//     _sellerId = sellerId;
//     _sellerName = sellerName;
//     _id = id;
//     _stock = stock;
//     _name = name;
//     _categoryId = categoryId;
//     _shortDescription = shortDescription;
//     _slug = slug;
//     _description = description;
//     _totalAllowedQuantity = totalAllowedQuantity;
//     _deliverableType = deliverableType;
//     _deliverableZipcodes = deliverableZipcodes;
//     _minimumOrderQuantity = minimumOrderQuantity;
//     _quantityStepSize = quantityStepSize;
//     _codAllowed = codAllowed;
//     _rowOrder = rowOrder;
//     _rating = rating;
//     _noOfRatings = noOfRatings;
//     _image = image;
//     _isReturnable = isReturnable;
//     _isCancelable = isCancelable;
//     _cancelableTill = cancelableTill;
//     _indicator = indicator;
//     _otherImages = otherImages;
//     _videoType = videoType;
//     _video = video;
//     _tags = tags;
//     _warrantyPeriod = warrantyPeriod;
//     _attributeTitle = attributeTitle;
//     _attributeValue = attributeValue;
//     _guaranteePeriod = guaranteePeriod;
//     _madeIn = madeIn;
//     _availability = availability;
//     _categoryName = categoryName;
//     _subCatName = subCatName;
//     _taxPercentage = taxPercentage;
//     _reviewImages = reviewImages;
//     _attributes = attributes;
//     _variants = variants;
//     _minMaxPrice = minMaxPrice;
//     _deliverableZipcodesIds = deliverableZipcodesIds;
//     _isDeliverable = isDeliverable;
//     _isPurchased = isPurchased;
//     _isFavorite = isFavorite;
//     _imageMd = imageMd;
//     _imageSm = imageSm;
//     _otherImagesMd = otherImagesMd;
//     _otherImagesSm = otherImagesSm;
//     _variantAttributes = variantAttributes;
//     _extraDescription = extraDescription;
// }
//
//   Data.fromJson(dynamic json) {
//     _total = json['total'];
//     _sales = json['sales'];
//     _stockType = json['stock_type'];
//     _isPricesInclusiveTax = json['is_prices_inclusive_tax'];
//     _type = json['type'];
//     _attrValueIds = json['attr_value_ids'];
//     _sellerRating = json['seller_rating'];
//     _sellerSlug = json['seller_slug'];
//     _sellerNoOfRatings = json['seller_no_of_ratings'];
//     _sellerProfile = json['seller_profile'];
//     _storeName = json['store_name'];
//     _storeDescription = json['store_description'];
//     _sellerId = json['seller_id'];
//     _sellerName = json['seller_name'];
//     _id = json['id'];
//     _stock = json['stock'];
//     _name = json['name'];
//     _categoryId = json['category_id'];
//     _shortDescription = json['short_description'];
//      _extraDescription= json['extra_description'];
//     _slug = json['slug'];
//     _description = json['description'];
//     _totalAllowedQuantity = json['total_allowed_quantity'];
//     _deliverableType = json['deliverable_type'];
//     _deliverableZipcodes = json['deliverable_zipcodes'];
//     _minimumOrderQuantity = json['minimum_order_quantity'];
//     _quantityStepSize = json['quantity_step_size'];
//     _codAllowed = json['cod_allowed'];
//     _rowOrder = json['row_order'];
//     _rating = json['rating'];
//     _noOfRatings = json['no_of_ratings'];
//     _image = json['image'];
//     _isReturnable = json['is_returnable'];
//     _isCancelable = json['is_cancelable'];
//     _cancelableTill = json['cancelable_till'];
//     _indicator = json['indicator'];
//     _otherImages = json['other_images'] != null ? json['other_images'].cast<String>() : [];
//     _videoType = json['video_type'];
//     _video = json['video'];
//     _tags = json['tags'] != null ? json['tags'].cast<String>() : [];
//     _warrantyPeriod = json['warranty_period'];
//     _attributeTitle = json['attribute_title'];
//     _attributeValue = json['attribute_value'];
//     _guaranteePeriod = json['guarantee_period'];
//     _madeIn = json['made_in'];
//     _availability = json['availability'];
//     _categoryName = json['category_name'];
//     _subCatName = json['sub_cat_name'];
//     _taxPercentage = json['tax_percentage'];
//     if (json['review_images'] != null) {
//       _reviewImages = [];
//       json['review_images'].forEach((v) {
//         _reviewImages?.add(v.fromJson(v));
//       });
//     }
//     if (json['attributes'] != null) {
//       _attributes = [];
//       json['attributes'].forEach((v) {
//         _attributes?.add(Attributes.fromJson(v));
//       });
//     }
//     if (json['variants'] != null) {
//       _variants = [];
//       json['variants'].forEach((v) {
//         _variants?.add(Variants.fromJson(v));
//       });
//     }
//     _minMaxPrice = json['min_max_price'] != null ? MinMaxPrice.fromJson(json['min_max_price']) : null;
//     _deliverableZipcodesIds = json['deliverable_zipcodes_ids'];
//     _isDeliverable = json['is_deliverable'];
//     _isPurchased = json['is_purchased'];
//     _isFavorite = json['is_favorite'];
//     _imageMd = json['image_md'];
//     _imageSm = json['image_sm'];
//     _otherImagesMd = json['other_images_md'] != null ? json['other_images_md'].cast<String>() : [];
//     _otherImagesSm = json['other_images_sm'] != null ? json['other_images_sm'].cast<String>() : [];
//     if (json['variant_attributes'] != null) {
//       _variantAttributes = [];
//       json['variant_attributes'].forEach((v) {
//         _variantAttributes?.add(v.fromJson(v));
//       });
//     }
//   }
//   String? _total;
//   String? _sales;
//   dynamic _stockType;
//   String? _isPricesInclusiveTax;
//   String? _type;
//   String? _attrValueIds;
//   String? _sellerRating;
//   dynamic _sellerSlug;
//   String? _sellerNoOfRatings;
//   String? _sellerProfile;
//   String? _storeName;
//   String? _storeDescription;
//   String? _extraDescription;
//   String? _sellerId;
//   String? _sellerName;
//   String? _id;
//   dynamic _stock;
//   String? _name;
//   String? _categoryId;
//   String? _shortDescription;
//   String? _slug;
//   String? _description;
//   String? _totalAllowedQuantity;
//   String? _deliverableType;
//   dynamic _deliverableZipcodes;
//   String? _minimumOrderQuantity;
//   String? _quantityStepSize;
//   String? _codAllowed;
//   String? _rowOrder;
//   String? _rating;
//   String? _noOfRatings;
//   String? _image;
//   String? _isReturnable;
//   String? _isCancelable;
//   String? _cancelableTill;
//   String? _indicator;
//   List<String>? _otherImages;
//   String? _videoType;
//   String? _video;
//   List<String>? _tags;
//   String? _warrantyPeriod;
//   String? _attributeTitle;
//   String? _attributeValue;
//   String? _guaranteePeriod;
//   String? _madeIn;
//   dynamic _availability;
//   String? _categoryName;
//   String? _subCatName;
//   String? _taxPercentage;
//   List<dynamic>? _reviewImages;
//   List<Attributes>? _attributes;
//   List<Variants>? _variants;
//   MinMaxPrice? _minMaxPrice;
//   dynamic _deliverableZipcodesIds;
//   bool? _isDeliverable;
//   bool? _isPurchased;
//   String? _isFavorite;
//   String? _imageMd;
//   String? _imageSm;
//   List<String>? _otherImagesMd;
//   List<String>? _otherImagesSm;
//   List<dynamic>? _variantAttributes;
// Data copyWith({  String? total,
//   String? sales,
//   dynamic stockType,
//   String? isPricesInclusiveTax,
//   String? type,
//   String? attrValueIds,
//   String? sellerRating,
//   dynamic sellerSlug,
//   String? sellerNoOfRatings,
//   String? sellerProfile,
//   String? storeName,
//   String? storeDescription,
//   String? sellerId,
//   String? sellerName,
//   String? id,
//   dynamic stock,
//   String? name,
//   String? categoryId,
//   String? shortDescription,
//   String? extraDescription,
//   String? slug,
//   String? description,
//   String? totalAllowedQuantity,
//   String? deliverableType,
//   dynamic deliverableZipcodes,
//   String? minimumOrderQuantity,
//   String? quantityStepSize,
//   String? codAllowed,
//   String? rowOrder,
//   String? rating,
//   String? noOfRatings,
//   String? image,
//   String? isReturnable,
//   String? isCancelable,
//   String? cancelableTill,
//   String? indicator,
//   List<String>? otherImages,
//   String? videoType,
//   String? video,
//   List<String>? tags,
//   String? warrantyPeriod,
//   String? attributeTitle,
//   String? attributeValue,
//   String? guaranteePeriod,
//   String? madeIn,
//   dynamic availability,
//   String? categoryName,
//   String? subCatName,
//   String? taxPercentage,
//   List<dynamic>? reviewImages,
//   List<Attributes>? attributes,
//   List<Variants>? variants,
//   MinMaxPrice? minMaxPrice,
//   dynamic deliverableZipcodesIds,
//   bool? isDeliverable,
//   bool? isPurchased,
//   String? isFavorite,
//   String? imageMd,
//   String? imageSm,
//   List<String>? otherImagesMd,
//   List<String>? otherImagesSm,
//   List<dynamic>? variantAttributes,
// }) => Data(  total: total ?? _total,
//   sales: sales ?? _sales,
//   stockType: stockType ?? _stockType,
//   isPricesInclusiveTax: isPricesInclusiveTax ?? _isPricesInclusiveTax,
//   type: type ?? _type,
//   attrValueIds: attrValueIds ?? _attrValueIds,
//   sellerRating: sellerRating ?? _sellerRating,
//   sellerSlug: sellerSlug ?? _sellerSlug,
//   sellerNoOfRatings: sellerNoOfRatings ?? _sellerNoOfRatings,
//   sellerProfile: sellerProfile ?? _sellerProfile,
//   storeName: storeName ?? _storeName,
//   storeDescription: storeDescription ?? _storeDescription,
//   extraDescription: extraDescription ?? _extraDescription,
//   sellerId: sellerId ?? _sellerId,
//   sellerName: sellerName ?? _sellerName,
//   id: id ?? _id,
//   stock: stock ?? _stock,
//   name: name ?? _name,
//   categoryId: categoryId ?? _categoryId,
//   shortDescription: shortDescription ?? _shortDescription,
//   slug: slug ?? _slug,
//   description: description ?? _description,
//   totalAllowedQuantity: totalAllowedQuantity ?? _totalAllowedQuantity,
//   deliverableType: deliverableType ?? _deliverableType,
//   deliverableZipcodes: deliverableZipcodes ?? _deliverableZipcodes,
//   minimumOrderQuantity: minimumOrderQuantity ?? _minimumOrderQuantity,
//   quantityStepSize: quantityStepSize ?? _quantityStepSize,
//   codAllowed: codAllowed ?? _codAllowed,
//   rowOrder: rowOrder ?? _rowOrder,
//   rating: rating ?? _rating,
//   noOfRatings: noOfRatings ?? _noOfRatings,
//   image: image ?? _image,
//   isReturnable: isReturnable ?? _isReturnable,
//   isCancelable: isCancelable ?? _isCancelable,
//   cancelableTill: cancelableTill ?? _cancelableTill,
//   indicator: indicator ?? _indicator,
//   otherImages: otherImages ?? _otherImages,
//   videoType: videoType ?? _videoType,
//   video: video ?? _video,
//   tags: tags ?? _tags,
//   warrantyPeriod: warrantyPeriod ?? _warrantyPeriod,
//   attributeTitle: attributeTitle ?? _attributeTitle,
//   attributeValue: attributeValue ?? _attributeValue,
//   guaranteePeriod: guaranteePeriod ?? _guaranteePeriod,
//   madeIn: madeIn ?? _madeIn,
//   availability: availability ?? _availability,
//   categoryName: categoryName ?? _categoryName,
//   subCatName: subCatName ?? _subCatName,
//   taxPercentage: taxPercentage ?? _taxPercentage,
//   reviewImages: reviewImages ?? _reviewImages,
//   attributes: attributes ?? _attributes,
//   variants: variants ?? _variants,
//   minMaxPrice: minMaxPrice ?? _minMaxPrice,
//   deliverableZipcodesIds: deliverableZipcodesIds ?? _deliverableZipcodesIds,
//   isDeliverable: isDeliverable ?? _isDeliverable,
//   isPurchased: isPurchased ?? _isPurchased,
//   isFavorite: isFavorite ?? _isFavorite,
//   imageMd: imageMd ?? _imageMd,
//   imageSm: imageSm ?? _imageSm,
//   otherImagesMd: otherImagesMd ?? _otherImagesMd,
//   otherImagesSm: otherImagesSm ?? _otherImagesSm,
//   variantAttributes: variantAttributes ?? _variantAttributes,
// );
//   String? get total => _total;
//   String? get sales => _sales;
//   dynamic get stockType => _stockType;
//   String? get isPricesInclusiveTax => _isPricesInclusiveTax;
//   String? get type => _type;
//   String? get attrValueIds => _attrValueIds;
//   String? get sellerRating => _sellerRating;
//   dynamic get sellerSlug => _sellerSlug;
//   String? get sellerNoOfRatings => _sellerNoOfRatings;
//   String? get sellerProfile => _sellerProfile;
//   String? get storeName => _storeName;
//   String? get storeDescription => _storeDescription;
//   String? get extraDescription => _extraDescription;
//   String? get sellerId => _sellerId;
//   String? get sellerName => _sellerName;
//   String? get id => _id;
//   dynamic get stock => _stock;
//   String? get name => _name;
//   String? get categoryId => _categoryId;
//   String? get shortDescription => _shortDescription;
//   String? get slug => _slug;
//   String? get description => _description;
//   String? get totalAllowedQuantity => _totalAllowedQuantity;
//   String? get deliverableType => _deliverableType;
//   dynamic get deliverableZipcodes => _deliverableZipcodes;
//   String? get minimumOrderQuantity => _minimumOrderQuantity;
//   String? get quantityStepSize => _quantityStepSize;
//   String? get codAllowed => _codAllowed;
//   String? get rowOrder => _rowOrder;
//   String? get rating => _rating;
//   String? get noOfRatings => _noOfRatings;
//   String? get image => _image;
//   String? get isReturnable => _isReturnable;
//   String? get isCancelable => _isCancelable;
//   String? get cancelableTill => _cancelableTill;
//   String? get indicator => _indicator;
//   List<String>? get otherImages => _otherImages;
//   String? get videoType => _videoType;
//   String? get video => _video;
//   List<String>? get tags => _tags;
//   String? get warrantyPeriod => _warrantyPeriod;
//   String? get attributeTitle => _attributeTitle;
//   String? get attributeValue => _attributeValue;
//   String? get guaranteePeriod => _guaranteePeriod;
//   String? get madeIn => _madeIn;
//   dynamic get availability => _availability;
//   String? get categoryName => _categoryName;
//   String? get subCatName => _subCatName;
//   String? get taxPercentage => _taxPercentage;
//   List<dynamic>? get reviewImages => _reviewImages;
//   List<Attributes>? get attributes => _attributes;
//   List<Variants>? get variants => _variants;
//   MinMaxPrice? get minMaxPrice => _minMaxPrice;
//   dynamic get deliverableZipcodesIds => _deliverableZipcodesIds;
//   bool? get isDeliverable => _isDeliverable;
//   bool? get isPurchased => _isPurchased;
//   String? get isFavorite => _isFavorite;
//   String? get imageMd => _imageMd;
//   String? get imageSm => _imageSm;
//   List<String>? get otherImagesMd => _otherImagesMd;
//   List<String>? get otherImagesSm => _otherImagesSm;
//   List<dynamic>? get variantAttributes => _variantAttributes;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['total'] = _total;
//     map['sales'] = _sales;
//     map['stock_type'] = _stockType;
//     map['is_prices_inclusive_tax'] = _isPricesInclusiveTax;
//     map['type'] = _type;
//     map['attr_value_ids'] = _attrValueIds;
//     map['seller_rating'] = _sellerRating;
//     map['seller_slug'] = _sellerSlug;
//     map['seller_no_of_ratings'] = _sellerNoOfRatings;
//     map['seller_profile'] = _sellerProfile;
//     map['store_name'] = _storeName;
//     map['store_description'] = _storeDescription;
//     map['seller_id'] = _sellerId;
//     map['seller_name'] = _sellerName;
//     map['id'] = _id;
//     map['stock'] = _stock;
//     map['name'] = _name;
//     map['category_id'] = _categoryId;
//     map['short_description'] = _shortDescription;
//     map['slug'] = _slug;
//     map['description'] = _description;
//     map['total_allowed_quantity'] = _totalAllowedQuantity;
//     map['deliverable_type'] = _deliverableType;
//     map['deliverable_zipcodes'] = _deliverableZipcodes;
//     map['minimum_order_quantity'] = _minimumOrderQuantity;
//     map['quantity_step_size'] = _quantityStepSize;
//     map['cod_allowed'] = _codAllowed;
//     map['row_order'] = _rowOrder;
//     map['rating'] = _rating;
//     map['no_of_ratings'] = _noOfRatings;
//     map['image'] = _image;
//     map['is_returnable'] = _isReturnable;
//     map['is_cancelable'] = _isCancelable;
//     map['cancelable_till'] = _cancelableTill;
//     map['indicator'] = _indicator;
//     map['other_images'] = _otherImages;
//     map['video_type'] = _videoType;
//     map['video'] = _video;
//     map['tags'] = _tags;
//     map['warranty_period'] = _warrantyPeriod;
//     map['attribute_title'] = _attributeTitle;
//     map['attribute_value'] = _attributeValue;
//     map['guarantee_period'] = _guaranteePeriod;
//     map['made_in'] = _madeIn;
//     map['availability'] = _availability;
//     map['category_name'] = _categoryName;
//     map['sub_cat_name'] = _subCatName;
//     map['tax_percentage'] = _taxPercentage;
//     if (_reviewImages != null) {
//       map['review_images'] = _reviewImages?.map((v) => v.toJson()).toList();
//     }
//     if (_attributes != null) {
//       map['attributes'] = _attributes?.map((v) => v.toJson()).toList();
//     }
//     if (_variants != null) {
//       map['variants'] = _variants?.map((v) => v.toJson()).toList();
//     }
//     if (_minMaxPrice != null) {
//       map['min_max_price'] = _minMaxPrice?.toJson();
//     }
//     map['deliverable_zipcodes_ids'] = _deliverableZipcodesIds;
//     map['is_deliverable'] = _isDeliverable;
//     map['is_purchased'] = _isPurchased;
//     map['is_favorite'] = _isFavorite;
//     map['image_md'] = _imageMd;
//     map['image_sm'] = _imageSm;
//     map['other_images_md'] = _otherImagesMd;
//     map['other_images_sm'] = _otherImagesSm;
//     if (_variantAttributes != null) {
//       map['variant_attributes'] = _variantAttributes?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
//
// }
//
// /// min_price : 4
// /// max_price : 4
// /// special_price : 2
// /// max_special_price : 2
// /// discount_in_percentage : 50
//
// class MinMaxPrice {
//   MinMaxPrice({
//       num? minPrice,
//       num? maxPrice,
//       num? specialPrice,
//       num? maxSpecialPrice,
//       num? discountInPercentage,}){
//     _minPrice = minPrice;
//     _maxPrice = maxPrice;
//     _specialPrice = specialPrice;
//     _maxSpecialPrice = maxSpecialPrice;
//     _discountInPercentage = discountInPercentage;
// }
//
//   MinMaxPrice.fromJson(dynamic json) {
//     _minPrice = json['min_price'];
//     _maxPrice = json['max_price'];
//     _specialPrice = json['special_price'];
//     _maxSpecialPrice = json['max_special_price'];
//     _discountInPercentage = json['discount_in_percentage'];
//   }
//   num? _minPrice;
//   num? _maxPrice;
//   num? _specialPrice;
//   num? _maxSpecialPrice;
//   num? _discountInPercentage;
// MinMaxPrice copyWith({  num? minPrice,
//   num? maxPrice,
//   num? specialPrice,
//   num? maxSpecialPrice,
//   num? discountInPercentage,
// }) => MinMaxPrice(  minPrice: minPrice ?? _minPrice,
//   maxPrice: maxPrice ?? _maxPrice,
//   specialPrice: specialPrice ?? _specialPrice,
//   maxSpecialPrice: maxSpecialPrice ?? _maxSpecialPrice,
//   discountInPercentage: discountInPercentage ?? _discountInPercentage,
// );
//   num? get minPrice => _minPrice;
//   num? get maxPrice => _maxPrice;
//   num? get specialPrice => _specialPrice;
//   num? get maxSpecialPrice => _maxSpecialPrice;
//   num? get discountInPercentage => _discountInPercentage;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['min_price'] = _minPrice;
//     map['max_price'] = _maxPrice;
//     map['special_price'] = _specialPrice;
//     map['max_special_price'] = _maxSpecialPrice;
//     map['discount_in_percentage'] = _discountInPercentage;
//     return map;
//   }
//
// }
//
// /// id : "228"
// /// product_id : "277"
// /// attribute_value_ids : ""
// /// attribute_set : ""
// /// price : "4"
// /// special_price : "2"
// /// sku : ""
// /// stock : null
// /// weight : "0"
// /// height : "0"
// /// breadth : "0"
// /// length : "0"
// /// images : []
// /// availability : ""
// /// status : "1"
// /// date_added : "2023-10-17 13:14:40"
// /// color : ""
// /// packete : ""
// /// variant_ids : ""
// /// attr_name : ""
// /// variant_values : ""
// /// swatche_type : ""
// /// swatche_value : ""
// /// images_md : []
// /// images_sm : []
// /// cart_count : "0"
//
// class Variants {
//   Variants({
//       String? id,
//       String? productId,
//       String? attributeValueIds,
//       String? attributeSet,
//       String? price,
//       String? specialPrice,
//       String? sku,
//       dynamic stock,
//       String? weight,
//       String? height,
//       String? breadth,
//       String? length,
//       List<dynamic>? images,
//       String? availability,
//       String? status,
//       String? dateAdded,
//       String? color,
//       String? packete,
//       String? variantIds,
//       String? attrName,
//       String? variantValues,
//       String? swatcheType,
//       String? swatcheValue,
//       List<dynamic>? imagesMd,
//       List<dynamic>? imagesSm,
//       String? cartCount,}){
//     _id = id;
//     _productId = productId;
//     _attributeValueIds = attributeValueIds;
//     _attributeSet = attributeSet;
//     _price = price;
//     _specialPrice = specialPrice;
//     _sku = sku;
//     _stock = stock;
//     _weight = weight;
//     _height = height;
//     _breadth = breadth;
//     _length = length;
//     _images = images;
//     _availability = availability;
//     _status = status;
//     _dateAdded = dateAdded;
//     _color = color;
//     _packete = packete;
//     _variantIds = variantIds;
//     _attrName = attrName;
//     _variantValues = variantValues;
//     _swatcheType = swatcheType;
//     _swatcheValue = swatcheValue;
//     _imagesMd = imagesMd;
//     _imagesSm = imagesSm;
//     _cartCount = cartCount;
// }
//
//   Variants.fromJson(dynamic json) {
//     _id = json['id'];
//     _productId = json['product_id'];
//     _attributeValueIds = json['attribute_value_ids'];
//     _attributeSet = json['attribute_set'];
//     _price = json['price'];
//     _specialPrice = json['special_price'];
//     _sku = json['sku'];
//     _stock = json['stock'];
//     _weight = json['weight'];
//     _height = json['height'];
//     _breadth = json['breadth'];
//     _length = json['length'];
//     if (json['images'] != null) {
//       _images = [];
//       json['images'].forEach((v) {
//         _images?.add(v.fromJson(v));
//       });
//     }
//     _availability = json['availability'];
//     _status = json['status'];
//     _dateAdded = json['date_added'];
//     _color = json['color'];
//     _packete = json['packete'];
//     _variantIds = json['variant_ids'];
//     _attrName = json['attr_name'];
//     _variantValues = json['variant_values'];
//     _swatcheType = json['swatche_type'];
//     _swatcheValue = json['swatche_value'];
//     if (json['images_md'] != null) {
//       _imagesMd = [];
//       json['images_md'].forEach((v) {
//         _imagesMd?.add(v.fromJson(v));
//       });
//     }
//     if (json['images_sm'] != null) {
//       _imagesSm = [];
//       json['images_sm'].forEach((v) {
//         _imagesSm?.add(v.fromJson(v));
//       });
//     }
//     _cartCount = json['cart_count'];
//   }
//   String? _id;
//   String? _productId;
//   String? _attributeValueIds;
//   String? _attributeSet;
//   String? _price;
//   String? _specialPrice;
//   String? _sku;
//   dynamic _stock;
//   String? _weight;
//   String? _height;
//   String? _breadth;
//   String? _length;
//   List<dynamic>? _images;
//   String? _availability;
//   String? _status;
//   String? _dateAdded;
//   String? _color;
//   String? _packete;
//   String? _variantIds;
//   String? _attrName;
//   String? _variantValues;
//   String? _swatcheType;
//   String? _swatcheValue;
//   List<dynamic>? _imagesMd;
//   List<dynamic>? _imagesSm;
//   String? _cartCount;
// Variants copyWith({  String? id,
//   String? productId,
//   String? attributeValueIds,
//   String? attributeSet,
//   String? price,
//   String? specialPrice,
//   String? sku,
//   dynamic stock,
//   String? weight,
//   String? height,
//   String? breadth,
//   String? length,
//   List<dynamic>? images,
//   String? availability,
//   String? status,
//   String? dateAdded,
//   String? color,
//   String? packete,
//   String? variantIds,
//   String? attrName,
//   String? variantValues,
//   String? swatcheType,
//   String? swatcheValue,
//   List<dynamic>? imagesMd,
//   List<dynamic>? imagesSm,
//   String? cartCount,
// }) => Variants(  id: id ?? _id,
//   productId: productId ?? _productId,
//   attributeValueIds: attributeValueIds ?? _attributeValueIds,
//   attributeSet: attributeSet ?? _attributeSet,
//   price: price ?? _price,
//   specialPrice: specialPrice ?? _specialPrice,
//   sku: sku ?? _sku,
//   stock: stock ?? _stock,
//   weight: weight ?? _weight,
//   height: height ?? _height,
//   breadth: breadth ?? _breadth,
//   length: length ?? _length,
//   images: images ?? _images,
//   availability: availability ?? _availability,
//   status: status ?? _status,
//   dateAdded: dateAdded ?? _dateAdded,
//   color: color ?? _color,
//   packete: packete ?? _packete,
//   variantIds: variantIds ?? _variantIds,
//   attrName: attrName ?? _attrName,
//   variantValues: variantValues ?? _variantValues,
//   swatcheType: swatcheType ?? _swatcheType,
//   swatcheValue: swatcheValue ?? _swatcheValue,
//   imagesMd: imagesMd ?? _imagesMd,
//   imagesSm: imagesSm ?? _imagesSm,
//   cartCount: cartCount ?? _cartCount,
// );
//   String? get id => _id;
//   String? get productId => _productId;
//   String? get attributeValueIds => _attributeValueIds;
//   String? get attributeSet => _attributeSet;
//   String? get price => _price;
//   String? get specialPrice => _specialPrice;
//   String? get sku => _sku;
//   dynamic get stock => _stock;
//   String? get weight => _weight;
//   String? get height => _height;
//   String? get breadth => _breadth;
//   String? get length => _length;
//   List<dynamic>? get images => _images;
//   String? get availability => _availability;
//   String? get status => _status;
//   String? get dateAdded => _dateAdded;
//   String? get color => _color;
//   String? get packete => _packete;
//   String? get variantIds => _variantIds;
//   String? get attrName => _attrName;
//   String? get variantValues => _variantValues;
//   String? get swatcheType => _swatcheType;
//   String? get swatcheValue => _swatcheValue;
//   List<dynamic>? get imagesMd => _imagesMd;
//   List<dynamic>? get imagesSm => _imagesSm;
//   String? get cartCount => _cartCount;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = _id;
//     map['product_id'] = _productId;
//     map['attribute_value_ids'] = _attributeValueIds;
//     map['attribute_set'] = _attributeSet;
//     map['price'] = _price;
//     map['special_price'] = _specialPrice;
//     map['sku'] = _sku;
//     map['stock'] = _stock;
//     map['weight'] = _weight;
//     map['height'] = _height;
//     map['breadth'] = _breadth;
//     map['length'] = _length;
//     if (_images != null) {
//       map['images'] = _images?.map((v) => v.toJson()).toList();
//     }
//     map['availability'] = _availability;
//     map['status'] = _status;
//     map['date_added'] = _dateAdded;
//     map['color'] = _color;
//     map['packete'] = _packete;
//     map['variant_ids'] = _variantIds;
//     map['attr_name'] = _attrName;
//     map['variant_values'] = _variantValues;
//     map['swatche_type'] = _swatcheType;
//     map['swatche_value'] = _swatcheValue;
//     if (_imagesMd != null) {
//       map['images_md'] = _imagesMd?.map((v) => v.toJson()).toList();
//     }
//     if (_imagesSm != null) {
//       map['images_sm'] = _imagesSm?.map((v) => v.toJson()).toList();
//     }
//     map['cart_count'] = _cartCount;
//     return map;
//   }
//
// }
//
// /// ids : "1"
// /// value : " clothes winter"
// /// attr_name : "test"
// /// name : "test"
// /// swatche_type : "2"
// /// swatche_value : "httpS://developmentalphawizz.com/B2B/uploads/media/2023/thumb-sm/Antsnest.jpeg"
//
// class Attributes {
//   Attributes({
//       String? ids,
//       String? value,
//       String? attrName,
//       String? name,
//       String? swatcheType,
//       String? swatcheValue,}){
//     _ids = ids;
//     _value = value;
//     _attrName = attrName;
//     _name = name;
//     _swatcheType = swatcheType;
//     _swatcheValue = swatcheValue;
// }
//
//   Attributes.fromJson(dynamic json) {
//     _ids = json['ids'];
//     _value = json['value'];
//     _attrName = json['attr_name'];
//     _name = json['name'];
//     _swatcheType = json['swatche_type'];
//     _swatcheValue = json['swatche_value'];
//   }
//   String? _ids;
//   String? _value;
//   String? _attrName;
//   String? _name;
//   String? _swatcheType;
//   String? _swatcheValue;
// Attributes copyWith({  String? ids,
//   String? value,
//   String? attrName,
//   String? name,
//   String? swatcheType,
//   String? swatcheValue,
// }) => Attributes(  ids: ids ?? _ids,
//   value: value ?? _value,
//   attrName: attrName ?? _attrName,
//   name: name ?? _name,
//   swatcheType: swatcheType ?? _swatcheType,
//   swatcheValue: swatcheValue ?? _swatcheValue,
// );
//   String? get ids => _ids;
//   String? get value => _value;
//   String? get attrName => _attrName;
//   String? get name => _name;
//   String? get swatcheType => _swatcheType;
//   String? get swatcheValue => _swatcheValue;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['ids'] = _ids;
//     map['value'] = _value;
//     map['attr_name'] = _attrName;
//     map['name'] = _name;
//     map['swatche_type'] = _swatcheType;
//     map['swatche_value'] = _swatcheValue;
//     return map;
//   }
//
// }
//
// /// attribute_values : "clothes winter"
// /// attribute_values_id : "1"
// /// name : "test"
// /// swatche_type : "2"
// /// swatche_value : "httpS://developmentalphawizz.com/B2B/uploads/media/2023/thumb-sm/Antsnest.jpeg"
//
// class Filters {
//   Filters({
//       String? attributeValues,
//       String? attributeValuesId,
//       String? name,
//       String? swatcheType,
//       String? swatcheValue,}){
//     _attributeValues = attributeValues;
//     _attributeValuesId = attributeValuesId;
//     _name = name;
//     _swatcheType = swatcheType;
//     _swatcheValue = swatcheValue;
// }
//
//   Filters.fromJson(dynamic json) {
//     _attributeValues = json['attribute_values'];
//     _attributeValuesId = json['attribute_values_id'];
//     _name = json['name'];
//     _swatcheType = json['swatche_type'];
//     _swatcheValue = json['swatche_value'];
//   }
//   String? _attributeValues;
//   String? _attributeValuesId;
//   String? _name;
//   String? _swatcheType;
//   String? _swatcheValue;
// Filters copyWith({  String? attributeValues,
//   String? attributeValuesId,
//   String? name,
//   String? swatcheType,
//   String? swatcheValue,
// }) => Filters(  attributeValues: attributeValues ?? _attributeValues,
//   attributeValuesId: attributeValuesId ?? _attributeValuesId,
//   name: name ?? _name,
//   swatcheType: swatcheType ?? _swatcheType,
//   swatcheValue: swatcheValue ?? _swatcheValue,
// );
//   String? get attributeValues => _attributeValues;
//   String? get attributeValuesId => _attributeValuesId;
//   String? get name => _name;
//   String? get swatcheType => _swatcheType;
//   String? get swatcheValue => _swatcheValue;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['attribute_values'] = _attributeValues;
//     map['attribute_values_id'] = _attributeValuesId;
//     map['name'] = _name;
//     map['swatche_type'] = _swatcheType;
//     map['swatche_value'] = _swatcheValue;
//     return map;
//   }
//
// }


// To parse this JSON data, do
//
//     final productUpdateModel = productUpdateModelFromJson(jsonString);

import 'dart:convert';

ProductUpdateModel productUpdateModelFromJson(String str) => ProductUpdateModel.fromJson(json.decode(str));

String productUpdateModelToJson(ProductUpdateModel data) => json.encode(data.toJson());

class ProductUpdateModel {
  bool error;
  String message;
  String minPrice;
  String maxPrice;
  String search;
  List<Filter> filters;
  List<String> tags;
  String total;
  String offset;
  List<dynamic> subcategories;
  List<Datum> data;

  ProductUpdateModel({
    required this.error,
    required this.message,
    required this.minPrice,
    required this.maxPrice,
    required this.search,
    required this.filters,
    required this.tags,
    required this.total,
    required this.offset,
    required this.subcategories,
    required this.data,
  });

  factory ProductUpdateModel.fromJson(Map<String, dynamic> json) => ProductUpdateModel(
    error: json["error"],
    message: json["message"],
    minPrice: json["min_price"],
    maxPrice: json["max_price"],
    search: json["search"],
    filters: List<Filter>.from(json["filters"].map((x) => Filter.fromJson(x))),
    tags: List<String>.from(json["tags"].map((x) => x)),
    total: json["total"],
    offset: json["offset"],
    subcategories: List<dynamic>.from(json["subcategories"].map((x) => x)),
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "min_price": minPrice,
    "max_price": maxPrice,
    "search": search,
    "filters": List<dynamic>.from(filters.map((x) => x.toJson())),
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "total": total,
    "offset": offset,
    "subcategories": List<dynamic>.from(subcategories.map((x) => x)),
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String total;
  String sales;
  dynamic stockType;
  String isPricesInclusiveTax;
  String type;
  String attrValueIds;
  String sellerRating;
  dynamic sellerSlug;
  String sellerNoOfRatings;
  String sellerProfile;
  String storeName;
  String storeDescription;
  String sellerId;
  String sellerName;
  String id;
  dynamic stock;
  String name;
  String categoryId;
  String shortDescription;
  String extraDescription;
  String slug;
  String description;
  String totalAllowedQuantity;
  String deliverableType;
  dynamic deliverableZipcodes;
  String minimumOrderQuantity;
  String quantityStepSize;
  String codAllowed;
  String rowOrder;
  String rating;
  String noOfRatings;
  String image;
  String isReturnable;
  String isCancelable;
  String cancelableTill;
  String indicator;
  List<String> otherImages;
  String videoType;
  String video;
  List<String> tags;
  String warrantyPeriod;
  String attributeTitle;
  String attributeValue;
  String brand;
  String subCatId;
  String address;
  String typeOfSeller;
  String stateName;
  dynamic countryName;
  String pincode;
  String destrict;
  String city;
  String area;
  dynamic street;
  String country;
  String guaranteePeriod;
  String broucherImage;
  String madeIn;
  dynamic availability;
  String categoryName;
  String subCatName;
  String taxPercentage;
  List<dynamic> reviewImages;
  List<Attribute> attributes;
  List<Variant> variants;
  MinMaxPrice minMaxPrice;
  dynamic deliverableZipcodesIds;
  List<ProductDatum> productData;
  bool isDeliverable;
  bool isPurchased;
  String isFavorite;
  String imageMd;
  String imageSm;
  List<String> otherImagesMd;
  List<String> otherImagesSm;
  List<dynamic> variantAttributes;

  Datum({
    required this.total,
    required this.sales,
    required this.stockType,
    required this.isPricesInclusiveTax,
    required this.type,
    required this.attrValueIds,
    required this.sellerRating,
    required this.sellerSlug,
    required this.sellerNoOfRatings,
    required this.sellerProfile,
    required this.storeName,
    required this.storeDescription,
    required this.sellerId,
    required this.sellerName,
    required this.id,
    required this.stock,
    required this.name,
    required this.categoryId,
    required this.shortDescription,
    required this.extraDescription,
    required this.slug,
    required this.description,
    required this.totalAllowedQuantity,
    required this.deliverableType,
    required this.deliverableZipcodes,
    required this.minimumOrderQuantity,
    required this.quantityStepSize,
    required this.codAllowed,
    required this.rowOrder,
    required this.rating,
    required this.noOfRatings,
    required this.image,
    required this.isReturnable,
    required this.isCancelable,
    required this.cancelableTill,
    required this.indicator,
    required this.otherImages,
    required this.videoType,
    required this.video,
    required this.tags,
    required this.warrantyPeriod,
    required this.attributeTitle,
    required this.attributeValue,
    required this.brand,
    required this.subCatId,
    required this.address,
    required this.typeOfSeller,
    required this.stateName,
    required this.countryName,
    required this.pincode,
    required this.destrict,
    required this.city,
    required this.area,
    required this.street,
    required this.country,
    required this.guaranteePeriod,
    required this.broucherImage,
    required this.madeIn,
    required this.availability,
    required this.categoryName,
    required this.subCatName,
    required this.taxPercentage,
    required this.reviewImages,
    required this.attributes,
    required this.variants,
    required this.minMaxPrice,
    required this.deliverableZipcodesIds,
    required this.productData,
    required this.isDeliverable,
    required this.isPurchased,
    required this.isFavorite,
    required this.imageMd,
    required this.imageSm,
    required this.otherImagesMd,
    required this.otherImagesSm,
    required this.variantAttributes,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    total: json["total"],
    sales: json["sales"],
    stockType: json["stock_type"],
    isPricesInclusiveTax: json["is_prices_inclusive_tax"],
    type: json["type"],
    attrValueIds: json["attr_value_ids"],
    sellerRating: json["seller_rating"],
    sellerSlug: json["seller_slug"],
    sellerNoOfRatings: json["seller_no_of_ratings"],
    sellerProfile: json["seller_profile"],
    storeName: json["store_name"],
    storeDescription: json["store_description"],
    sellerId: json["seller_id"],
    sellerName: json["seller_name"],
    id: json["id"],
    stock: json["stock"],
    name: json["name"],
    categoryId: json["category_id"],
    shortDescription: json["short_description"],
    extraDescription: json["extra_description"],
    slug: json["slug"],
    description: json["description"],
    totalAllowedQuantity: json["total_allowed_quantity"],
    deliverableType: json["deliverable_type"],
    deliverableZipcodes: json["deliverable_zipcodes"],
    minimumOrderQuantity: json["minimum_order_quantity"],
    quantityStepSize: json["quantity_step_size"],
    codAllowed: json["cod_allowed"],
    rowOrder: json["row_order"],
    rating: json["rating"],
    noOfRatings: json["no_of_ratings"],
    image: json["image"],
    isReturnable: json["is_returnable"],
    isCancelable: json["is_cancelable"],
    cancelableTill: json["cancelable_till"],
    indicator: json["indicator"],
    otherImages: List<String>.from(json["other_images"].map((x) => x)),
    videoType: json["video_type"],
    video: json["video"],
    tags: List<String>.from(json["tags"].map((x) => x)),
    warrantyPeriod: json["warranty_period"],
    attributeTitle: json["attribute_title"],
    attributeValue: json["attribute_value"],
    brand: json["brand"],
    subCatId: json["sub_cat_id"],
    address: json["address"],
    typeOfSeller: json["type_of_seller"],
    stateName: json["state_name"],
    countryName: json["country_name"],
    pincode: json["pincode"],
    destrict: json["destrict"],
    city: json["city"],
    area: json["area"],
    street: json["street"],
    country: json["country"],
    guaranteePeriod: json["guarantee_period"],
    broucherImage: json["broucher_image"],
    madeIn: json["made_in"],
    availability: json["availability"],
    categoryName: json["category_name"],
    subCatName: json["sub_cat_name"],
    taxPercentage: json["tax_percentage"],
    reviewImages: List<dynamic>.from(json["review_images"].map((x) => x)),
    attributes: List<Attribute>.from(json["attributes"].map((x) => Attribute.fromJson(x))),
    variants: List<Variant>.from(json["variants"].map((x) => Variant.fromJson(x))),
    minMaxPrice: MinMaxPrice.fromJson(json["min_max_price"]),
    deliverableZipcodesIds: json["deliverable_zipcodes_ids"],
    productData: List<ProductDatum>.from(json["product_data"].map((x) => ProductDatum.fromJson(x))),
    isDeliverable: json["is_deliverable"],
    isPurchased: json["is_purchased"],
    isFavorite: json["is_favorite"],
    imageMd: json["image_md"],
    imageSm: json["image_sm"],
    otherImagesMd: List<String>.from(json["other_images_md"].map((x) => x)),
    otherImagesSm: List<String>.from(json["other_images_sm"].map((x) => x)),
    variantAttributes: List<dynamic>.from(json["variant_attributes"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "sales": sales,
    "stock_type": stockType,
    "is_prices_inclusive_tax": isPricesInclusiveTax,
    "type": type,
    "attr_value_ids": attrValueIds,
    "seller_rating": sellerRating,
    "seller_slug": sellerSlug,
    "seller_no_of_ratings": sellerNoOfRatings,
    "seller_profile": sellerProfile,
    "store_name": storeName,
    "store_description": storeDescription,
    "seller_id": sellerId,
    "seller_name": sellerName,
    "id": id,
    "stock": stock,
    "name": name,
    "category_id": categoryId,
    "short_description": shortDescription,
    "extra_description": extraDescription,
    "slug": slug,
    "description": description,
    "total_allowed_quantity": totalAllowedQuantity,
    "deliverable_type": deliverableType,
    "deliverable_zipcodes": deliverableZipcodes,
    "minimum_order_quantity": minimumOrderQuantity,
    "quantity_step_size": quantityStepSize,
    "cod_allowed": codAllowed,
    "row_order": rowOrder,
    "rating": rating,
    "no_of_ratings": noOfRatings,
    "image": image,
    "is_returnable": isReturnable,
    "is_cancelable": isCancelable,
    "cancelable_till": cancelableTill,
    "indicator": indicator,
    "other_images": List<dynamic>.from(otherImages.map((x) => x)),
    "video_type": videoType,
    "video": video,
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "warranty_period": warrantyPeriod,
    "attribute_title": attributeTitle,
    "attribute_value": attributeValue,
    "brand": brand,
    "sub_cat_id": subCatId,
    "address": address,
    "type_of_seller": typeOfSeller,
    "state_name": stateName,
    "country_name": countryName,
    "pincode": pincode,
    "destrict": destrict,
    "city": city,
    "area": area,
    "street": street,
    "country": country,
    "guarantee_period": guaranteePeriod,
    "broucher_image": broucherImage,
    "made_in": madeIn,
    "availability": availability,
    "category_name": categoryName,
    "sub_cat_name": subCatName,
    "tax_percentage": taxPercentage,
    "review_images": List<dynamic>.from(reviewImages.map((x) => x)),
    "attributes": List<dynamic>.from(attributes.map((x) => x.toJson())),
    "variants": List<dynamic>.from(variants.map((x) => x.toJson())),
    "min_max_price": minMaxPrice.toJson(),
    "deliverable_zipcodes_ids": deliverableZipcodesIds,
    "product_data": List<dynamic>.from(productData.map((x) => x.toJson())),
    "is_deliverable": isDeliverable,
    "is_purchased": isPurchased,
    "is_favorite": isFavorite,
    "image_md": imageMd,
    "image_sm": imageSm,
    "other_images_md": List<dynamic>.from(otherImagesMd.map((x) => x)),
    "other_images_sm": List<dynamic>.from(otherImagesSm.map((x) => x)),
    "variant_attributes": List<dynamic>.from(variantAttributes.map((x) => x)),
  };
}

class Attribute {
  String ids;
  String value;
  String attrName;
  String name;
  String swatcheType;
  String swatcheValue;

  Attribute({
    required this.ids,
    required this.value,
    required this.attrName,
    required this.name,
    required this.swatcheType,
    required this.swatcheValue,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
    ids: json["ids"],
    value: json["value"],
    attrName: json["attr_name"],
    name: json["name"],
    swatcheType: json["swatche_type"],
    swatcheValue: json["swatche_value"],
  );

  Map<String, dynamic> toJson() => {
    "ids": ids,
    "value": value,
    "attr_name": attrName,
    "name": name,
    "swatche_type": swatcheType,
    "swatche_value": swatcheValue,
  };
}

class MinMaxPrice {
  int minPrice;
  int maxPrice;
  int specialPrice;
  int maxSpecialPrice;
  int discountInPercentage;

  MinMaxPrice({
    required this.minPrice,
    required this.maxPrice,
    required this.specialPrice,
    required this.maxSpecialPrice,
    required this.discountInPercentage,
  });

  factory MinMaxPrice.fromJson(Map<String, dynamic> json) => MinMaxPrice(
    minPrice: json["min_price"],
    maxPrice: json["max_price"],
    specialPrice: json["special_price"],
    maxSpecialPrice: json["max_special_price"],
    discountInPercentage: json["discount_in_percentage"],
  );

  Map<String, dynamic> toJson() => {
    "min_price": minPrice,
    "max_price": maxPrice,
    "special_price": specialPrice,
    "max_special_price": maxSpecialPrice,
    "discount_in_percentage": discountInPercentage,
  };
}

class ProductDatum {
  String title;
  String value;

  ProductDatum({
    required this.title,
    required this.value,
  });

  factory ProductDatum.fromJson(Map<String, dynamic> json) => ProductDatum(
    title: json["title"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "value": value,
  };
}

class Variant {
  String id;
  String productId;
  String attributeValueIds;
  String attributeSet;
  String price;
  String specialPrice;
  String sku;
  dynamic stock;
  String weight;
  String height;
  String breadth;
  String length;
  List<dynamic> images;
  String availability;
  String status;
  DateTime dateAdded;
  String color;
  String packete;
  String variantIds;
  String attrName;
  String variantValues;
  String swatcheType;
  String swatcheValue;
  List<dynamic> imagesMd;
  List<dynamic> imagesSm;
  String cartCount;

  Variant({
    required this.id,
    required this.productId,
    required this.attributeValueIds,
    required this.attributeSet,
    required this.price,
    required this.specialPrice,
    required this.sku,
    required this.stock,
    required this.weight,
    required this.height,
    required this.breadth,
    required this.length,
    required this.images,
    required this.availability,
    required this.status,
    required this.dateAdded,
    required this.color,
    required this.packete,
    required this.variantIds,
    required this.attrName,
    required this.variantValues,
    required this.swatcheType,
    required this.swatcheValue,
    required this.imagesMd,
    required this.imagesSm,
    required this.cartCount,
  });

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
    id: json["id"],
    productId: json["product_id"],
    attributeValueIds: json["attribute_value_ids"],
    attributeSet: json["attribute_set"],
    price: json["price"],
    specialPrice: json["special_price"],
    sku: json["sku"],
    stock: json["stock"],
    weight: json["weight"],
    height: json["height"],
    breadth: json["breadth"],
    length: json["length"],
    images: List<dynamic>.from(json["images"].map((x) => x)),
    availability: json["availability"],
    status: json["status"],
    dateAdded: DateTime.parse(json["date_added"]),
    color: json["color"],
    packete: json["packete"],
    variantIds: json["variant_ids"],
    attrName: json["attr_name"],
    variantValues: json["variant_values"],
    swatcheType: json["swatche_type"],
    swatcheValue: json["swatche_value"],
    imagesMd: List<dynamic>.from(json["images_md"].map((x) => x)),
    imagesSm: List<dynamic>.from(json["images_sm"].map((x) => x)),
    cartCount: json["cart_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "attribute_value_ids": attributeValueIds,
    "attribute_set": attributeSet,
    "price": price,
    "special_price": specialPrice,
    "sku": sku,
    "stock": stock,
    "weight": weight,
    "height": height,
    "breadth": breadth,
    "length": length,
    "images": List<dynamic>.from(images.map((x) => x)),
    "availability": availability,
    "status": status,
    "date_added": dateAdded.toIso8601String(),
    "color": color,
    "packete": packete,
    "variant_ids": variantIds,
    "attr_name": attrName,
    "variant_values": variantValues,
    "swatche_type": swatcheType,
    "swatche_value": swatcheValue,
    "images_md": List<dynamic>.from(imagesMd.map((x) => x)),
    "images_sm": List<dynamic>.from(imagesSm.map((x) => x)),
    "cart_count": cartCount,
  };
}

class Filter {
  String attributeValues;
  String attributeValuesId;
  String name;
  String swatcheType;
  String swatcheValue;

  Filter({
    required this.attributeValues,
    required this.attributeValuesId,
    required this.name,
    required this.swatcheType,
    required this.swatcheValue,
  });

  factory Filter.fromJson(Map<String, dynamic> json) => Filter(
    attributeValues: json["attribute_values"],
    attributeValuesId: json["attribute_values_id"],
    name: json["name"],
    swatcheType: json["swatche_type"],
    swatcheValue: json["swatche_value"],
  );

  Map<String, dynamic> toJson() => {
    "attribute_values": attributeValues,
    "attribute_values_id": attributeValuesId,
    "name": name,
    "swatche_type": swatcheType,
    "swatche_value": swatcheValue,
  };
}
