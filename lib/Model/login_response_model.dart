class LoginSuccessResponse {
  bool? error;
  String? message;
  LoginData? data;
  SellerData? sellerData;

  LoginSuccessResponse({this.error, this.message, this.data, this.sellerData});

  LoginSuccessResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    data = json['data'] != null ? LoginData.fromJson(json['data']) : null;
    sellerData = json['seller_data'] != null
        ? SellerData.fromJson(json['seller_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (sellerData != null) {
      data['seller_data'] = sellerData!.toJson();
    }
    return data;
  }
}

class LoginData {
  String? id;
  String? ipAddress;
  String? username;
  String? password;
  String? email;
  String? mobile;
  String? image;
  String? balance;
  String? activationSelector;
  String? activationCode;
  String? forgottenPasswordSelector;
  String? forgottenPasswordCode;
  String? forgottenPasswordTime;
  String? rememberSelector;
  String? rememberCode;
  String? createdOn;
  String? lastLogin;
  String? active;
  String? company;
  String? address;
  String? bonusType;
  String? bonus;
  String? cashReceived;
  String? dob;
  String? countryCode;
  String? city;
  String? destrict;
  String? area;
  String? street;
  String? pincode;
  String? serviceableZipcodes;
  String? apikey;
  String? referralCode;
  String? friendsCode;
  String? fcmId;
  String? latitude;
  String? longitude;
  String? type;
  String? createdAt;
  String? userType;
  String? typeOfSeller;
  String? state;
  String? country;
  String? subscriptionType;
  String? otp;
  String? broucher;
  String? media;

  LoginData(
      {this.id,
        this.ipAddress,
        this.username,
        this.password,
        this.email,
        this.mobile,
        this.image,
        this.balance,
        this.activationSelector,
        this.activationCode,
        this.forgottenPasswordSelector,
        this.forgottenPasswordCode,
        this.forgottenPasswordTime,
        this.rememberSelector,
        this.rememberCode,
        this.createdOn,
        this.lastLogin,
        this.active,
        this.company,
        this.address,
        this.bonusType,
        this.bonus,
        this.cashReceived,
        this.dob,
        this.countryCode,
        this.city,
        this.destrict,
        this.area,
        this.street,
        this.pincode,
        this.serviceableZipcodes,
        this.apikey,
        this.referralCode,
        this.friendsCode,
        this.fcmId,
        this.latitude,
        this.longitude,
        this.type,
        this.createdAt,
        this.userType,
        this.typeOfSeller,
        this.state,
        this.country,
        this.subscriptionType,
        this.otp,
        this.broucher,
        this.media});

  LoginData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ipAddress = json['ip_address'];
    username = json['username'];
    password = json['password'];
    email = json['email'];
    mobile = json['mobile'];
    image = json['image'];
    balance = json['balance'];
    activationSelector = json['activation_selector'];
    activationCode = json['activation_code'];
    forgottenPasswordSelector = json['forgotten_password_selector'];
    forgottenPasswordCode = json['forgotten_password_code'];
    forgottenPasswordTime = json['forgotten_password_time'];
    rememberSelector = json['remember_selector'];
    rememberCode = json['remember_code'];
    createdOn = json['created_on'];
    lastLogin = json['last_login'];
    active = json['active'];
    company = json['company'];
    address = json['address'];
    bonusType = json['bonus_type'];
    bonus = json['bonus'];
    cashReceived = json['cash_received'];
    dob = json['dob'];
    countryCode = json['country_code'];
    city = json['city'];
    destrict = json['destrict'];
    area = json['area'];
    street = json['street'];
    pincode = json['pincode'];
    serviceableZipcodes = json['serviceable_zipcodes'];
    apikey = json['apikey'];
    referralCode = json['referral_code'];
    friendsCode = json['friends_code'];
    fcmId = json['fcm_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    type = json['type'];
    createdAt = json['created_at'];
    userType = json['user_type'];
    typeOfSeller = json['type_of_seller'];
    state = json['state'];
    country = json['country'];
    subscriptionType = json['subscription_type'];
    otp = json['otp'];
    broucher = json['broucher'];
    media = json['media'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['ip_address'] = ipAddress;
    data['username'] = username;
    data['password'] = password;
    data['email'] = email;
    data['mobile'] = mobile;
    data['image'] = image;
    data['balance'] = balance;
    data['activation_selector'] = activationSelector;
    data['activation_code'] = activationCode;
    data['forgotten_password_selector'] = forgottenPasswordSelector;
    data['forgotten_password_code'] = forgottenPasswordCode;
    data['forgotten_password_time'] = forgottenPasswordTime;
    data['remember_selector'] = rememberSelector;
    data['remember_code'] = rememberCode;
    data['created_on'] = createdOn;
    data['last_login'] = lastLogin;
    data['active'] = active;
    data['company'] = company;
    data['address'] = address;
    data['bonus_type'] = bonusType;
    data['bonus'] = bonus;
    data['cash_received'] = cashReceived;
    data['dob'] = dob;
    data['country_code'] = countryCode;
    data['city'] = city;
    data['destrict'] = destrict;
    data['area'] = area;
    data['street'] = street;
    data['pincode'] = pincode;
    data['serviceable_zipcodes'] = serviceableZipcodes;
    data['apikey'] = apikey;
    data['referral_code'] = referralCode;
    data['friends_code'] = friendsCode;
    data['fcm_id'] = fcmId;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['type'] = type;
    data['created_at'] = createdAt;
    data['user_type'] = userType;
    data['type_of_seller'] = typeOfSeller;
    data['state'] = state;
    data['country'] = country;
    data['subscription_type'] = subscriptionType;
    data['otp'] = otp;
    data['broucher'] = broucher;
    data['media'] = media;
    return data;
  }
}

class SellerData {
  String? id;
  String? userId;
  String? slug;
  String? categoryIds;
  String? storeName;
  String? storeDescription;
  String? logo;
  String? storeUrl;
  String? noOfRatings;
  String? rating;
  String? bankName;
  String? bankCode;
  String? accountName;
  String? accountNumber;
  String? nationalIdentityCard;
  String? addressProof;
  String? authorizedSignature;
  String? panNumber;
  String? taxName;
  String? taxNumber;
  String? permissions;
  String? commission;
  String? status;
  String? dateAdded;
  String? udyogNum;
  String? partner;
  String? otherNumber;
  String? partnerNumber;
  String? companyAddress;
  String? facebook;
  String? instagram;
  String? webLink;
  String? linkedin;
  String? purchaseId;
  String? sellerCategoryId;
  String? partnerAddress;

  SellerData(
      {this.id,
        this.userId,
        this.slug,
        this.categoryIds,
        this.storeName,
        this.storeDescription,
        this.logo,
        this.storeUrl,
        this.noOfRatings,
        this.rating,
        this.bankName,
        this.bankCode,
        this.accountName,
        this.accountNumber,
        this.nationalIdentityCard,
        this.addressProof,
        this.authorizedSignature,
        this.panNumber,
        this.taxName,
        this.taxNumber,
        this.permissions,
        this.commission,
        this.status,
        this.dateAdded,
        this.udyogNum,
        this.partner,
        this.otherNumber,
        this.partnerNumber,
        this.companyAddress,
        this.facebook,
        this.instagram,
        this.webLink,
        this.linkedin,
        this.purchaseId,
        this.sellerCategoryId,
        this.partnerAddress});

  SellerData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    slug = json['slug'];
    categoryIds = json['category_ids'];
    storeName = json['store_name'];
    storeDescription = json['store_description'];
    logo = json['logo'];
    storeUrl = json['store_url'];
    noOfRatings = json['no_of_ratings'];
    rating = json['rating'];
    bankName = json['bank_name'];
    bankCode = json['bank_code'];
    accountName = json['account_name'];
    accountNumber = json['account_number'];
    nationalIdentityCard = json['national_identity_card'];
    addressProof = json['address_proof'];
    authorizedSignature = json['authorized_signature'];
    panNumber = json['pan_number'];
    taxName = json['tax_name'];
    taxNumber = json['tax_number'];
    permissions = json['permissions'];
    commission = json['commission'];
    status = json['status'];
    dateAdded = json['date_added'];
    udyogNum = json['udyog_num'];
    partner = json['partner'];
    otherNumber = json['other_number'];
    partnerNumber = json['partner_number'];
    companyAddress = json['company_address'];
    facebook = json['facebook'];
    instagram = json['instagram'];
    webLink = json['web_link'];
    linkedin = json['linkedin'];
    purchaseId = json['purchase_id'];
    sellerCategoryId = json['seller_category_id'];
    partnerAddress = json['partner_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['user_id'] = userId;
    data['slug'] = slug;
    data['category_ids'] = categoryIds;
    data['store_name'] = storeName;
    data['store_description'] = storeDescription;
    data['logo'] = logo;
    data['store_url'] = storeUrl;
    data['no_of_ratings'] = noOfRatings;
    data['rating'] = rating;
    data['bank_name'] = bankName;
    data['bank_code'] = bankCode;
    data['account_name'] = accountName;
    data['account_number'] = accountNumber;
    data['national_identity_card'] = nationalIdentityCard;
    data['address_proof'] = addressProof;
    data['authorized_signature'] = authorizedSignature;
    data['pan_number'] = panNumber;
    data['tax_name'] = taxName;
    data['tax_number'] = taxNumber;
    data['permissions'] = permissions;
    data['commission'] = commission;
    data['status'] = status;
    data['date_added'] = dateAdded;
    data['udyog_num'] = udyogNum;
    data['partner'] = partner;
    data['other_number'] = otherNumber;
    data['partner_number'] = partnerNumber;
    data['company_address'] = companyAddress;
    data['facebook'] = facebook;
    data['instagram'] = instagram;
    data['web_link'] = webLink;
    data['linkedin'] = linkedin;
    data['purchase_id'] = purchaseId;
    data['seller_category_id'] = sellerCategoryId;
    data['partner_address'] = partnerAddress;
    return data;
  }
}
