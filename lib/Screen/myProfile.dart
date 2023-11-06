import 'dart:convert';
import 'dart:io';
import 'package:b2b/AuthView/register.dart';
import 'package:b2b/apiServices/apiConstants.dart';
import 'package:b2b/widgets/Appbar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../Api.path.dart';
import '../Model/GetCountriesModel.dart';
import '../Model/GetStateModel.dart';
import '../Model/businessCategoruModel.dart';
import '../Model/updateUserModel.dart';
import '../color.dart';
import 'HomeScreen.dart';

UserUpdatemodel? store;

var Id;
String? categoryValue, stateValue, countryValue;

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);
  // String? name;
  // String? email;
  // String? mobile;
  //
  // // String? id;
  //
  // String? companyName;
  // String? bussinessAddress;
  // String? gstNumber;
  // String? udyogNumber;
  // String? bussinessCategory;
  // String? country;
  // String? state;
  // String? district;
  // String? area;
  // String? pinCode;
  // String? city;
  // String? partnerName;
  // String? partnerNumber;
  // String? googleAddress;
  // String? anyNumber;
  // String? websiteLink;
  // String? facebook;
  // String? insta;
  // String? linkdin;

  // MyProfile({
    // required this.name,
    // required this.email,
    // required this.mobile,
    // // required this.id,
    //
    // //required this.companyName,
    // required this.bussinessAddress,
    // required this.gstNumber,
    // required this.udyogNumber,
    // required this.bussinessCategory,
    // required this.country,
    // required this.state,
    // required this.district,
    // required this.area,
    // required this.pinCode,
    // required this.city,
    // required this.partnerName,
    // required this.partnerNumber,
    // required this.googleAddress,
    //   required this.anyNumber,
    // required this.websiteLink,
    // required this.facebook,
    // required this.insta,
    // required this.linkdin,
  // });
  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final _formKey = GlobalKey<FormState>();
  int index = 1;
  TextEditingController nameController =  TextEditingController();
  TextEditingController emailController =  TextEditingController();
  TextEditingController mobileController =  TextEditingController();
  TextEditingController companycontroller = TextEditingController();
  TextEditingController businessAddressController = TextEditingController();
  TextEditingController gstController = TextEditingController();
  TextEditingController udyogController = TextEditingController();
  TextEditingController businessCategoryController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController partnerNameController = TextEditingController();
  TextEditingController partnerNumberController = TextEditingController();
  TextEditingController googleAddressController = TextEditingController();
  TextEditingController anyController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController facebookController = TextEditingController();
  TextEditingController instaController = TextEditingController();
  TextEditingController linkdinController = TextEditingController();
  @override
  void initState() {
    getProfile();

    // TODO: implement initState
    nameController.text = namee;
    emailController.text = emaill;
    //mobileController.text = mobilee;
   // companycontroller.text = companyName2;
    //businessAddressController.text = bussinessAddress ;
   // companycontroller.text =
    // gstController.text = gstNumber;
    // udyogController.text = "${widget.udyogNumber}";
    //
    // businessCategoryController.text = "${widget.bussinessCategory}";
    //  countryController.text = "${widget.country}";
    //  stateController.text = "${widget.state}";
    //
    //  categoryValue="${widget.bussinessCategory}";

    //
    districtController.text = district2;
     areaController.text = area2;
      pincodeController.text = pinCode2;
     cityController.text = city2;
    //  partnerNameController.text = partnerName2;
    // partnerNumberController.text = partnerNumber2;
    // googleAddressController.text = "${widget.googleAddress}";
    // facebookController.text = "${widget.facebook}";
    // instaController.text = "${widget.insta}";
    // linkdinController.text = "${widget.linkdin}";

    super.initState();
  }

  BusinessCategoruModel? businesscatorymodel;

  businessCategory() async {
    var headers = {
      'Cookie': 'ci_session=115650123eb5c7aef18bb61014d5574c0d194b0f'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '${baseUrl}business_cat'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse =
          BusinessCategoruModel.fromJson(json.decode(finalResponse));

        businesscatorymodel = jsonResponse;

      businesscatorymodel?.data?.forEach((element) {
        if(element.name.toString() == bussinessCategory2.toString()){
          categoryValue = element.name.toString();
        }
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  String? country_id;
  GetCountriesModel? getcountriesmodel;

  getCountries() async {
    print("Country Apiiii");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var headers = {
      'Cookie': 'ci_session=dece0e2e0c31b826b2ea8639957e722dc6ea7594'
    };
    var request = http.MultipartRequest(
        'GET', Uri.parse('${baseUrl}get_countries'));

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse =
          GetCountriesModel.fromJson(json.decode(finalResponse));

        getcountriesmodel = jsonResponse;
        print('${country2}___________country2');
        getcountriesmodel?.data?.forEach((element) {


          if(element.id.toString() == country2.toString()) {
              countryValue = element.id.toString() ;


          }
        });
        setState(() {});
        if(countryValue !=null && countryValue!= ''){
          getState();

        }

    } else {
      print(response.reasonPhrase);
    }
  }

  GetStateModel? getStateModel;

  getState({bool? isFirstTime}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var headers = {
      'Cookie': 'ci_session=25d1931368856b143448ddb5454481b7645223e7'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            '${baseUrl}get_states'));
    request.fields.addAll({'country_id': countryValue!});
    print("get state parameter ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = GetStateModel.fromJson(json.decode(finalResponse));
      setState(() {
        getStateModel = jsonResponse;
      });

      if((state2 != null || state2 != '')) {
        getStateModel?.data?.forEach((element) {
        if(element.id.toString() == state2.toString()){
          stateValue = element.id ;
        }
      });
      }
      state2 = null ;
      setState(() {});
    } else {
      print(response.reasonPhrase);
    }
  }

  File? selectedImage;
  String base64Image = "";
  final ImagePicker _imagePicker = ImagePicker() ;


  Future<void> chooseImage(type) async {
    var image;
    if (type == "Camera") {
      image =  _imagePicker.pickImage(source: ImageSource.camera, imageQuality: 10);
    } else {
      image = _imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 25);
    }
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
        base64Image = base64Encode(selectedImage!.readAsBytesSync());
      });
    }
  }

  bool isExpanded = false;
  final _picker = ImagePicker();

  // String filepath="Images/dark.jpg";
  File? _image;

  getImageFile(ImageSource source) async {
    var image = await ImagePicker.platform.pickImage(source: source);
    setState(() {
      _image = image as File;
      print(_image?.lengthSync());
    });
  }

  void toggleExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }


  getProfile()async{
    final SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    var sessionId= sharedPreferences.getString('id');

    var headers = {
      'Cookie': 'ci_session=60e6733f1ca928a67f86820b734e34f4e5e0dd4e'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.getUserProfile}'));
    request.fields.addAll({
      'user_id': '${sessionId}'
    });

    print("get profile parameter ${request.fields}=======================");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result2=await response.stream.bytesToString();
      var profileStore = jsonDecode(result2);
      setState(() {
        profileStore2 = profileStore;
      });
    }
    if(profileStore2['error']==false){
      imagee= "${profileStore2['data']['broucher']}";
      namee= "${profileStore2['data']['username']}";
      emaill= "${profileStore2['data']['email']}";
      mobilee= "${profileStore2['data']['mobile']}";
      companyName2 = "${profileStore2['data']['company']}";
      bussinessAddress="${profileStore2['data']['address']}";
      bussinessAddress2="${profileStore2['seller_data']['company_address']}";
      gstNumber2="${profileStore2['seller_data']['tax_number']}";
      udyogNumber2="${profileStore2['seller_data']['udyog_num']}";
      bussinessCategory2="${profileStore2['data']['type_of_seller']}";
      country2="${profileStore2['data']['country']}";
      state2 ="${profileStore2['data']['state']}";

      district2="${profileStore2['data']['destrict']}";
      area2="${profileStore2['data']['area']}";
      pinCode2="${profileStore2['data']['pincode']}";
      city2="${profileStore2['data']['city']}";
      partnerName2="${profileStore2['seller_data']['partner']}";
      partnerNumber2="${profileStore2['seller_data']['partner_number']}";
      googleAddress2="${profileStore2['data']['address']}";
       anyNumber2="${profileStore2['data']['address']}";
      websiteLink2="${profileStore2['seller_data']['web_link']}";
      facebook2="${profileStore2['seller_data']['facebook']}";
      insta2="${profileStore2['seller_data']['instagram']}";
      linkdin2="${profileStore2['seller_data']['linkedin']}";
      nameController.text = namee;
      emailController.text = emaill;
      mobileController.text = mobilee;
      // companycontroller.text = companyName2;
      //businessAddressController.text = bussinessAddress ;
      // companycontroller.text =
      // gstController.text = gstNumber;
      // udyogController.text = "${widget.udyogNumber}";
      //
      // businessCategoryController.text = "${widget.bussinessCategory}";
      //  countryController.text = "${widget.country}";
      //  stateController.text = "${widget.state}";
      //
      //  categoryValue="${widget.bussinessCategory}";
       // countryValue= widget.country;
      //  stateValue= widget.state;
      //
      districtController.text = district2;
      areaController.text = area2;
      pincodeController.text = pinCode2;
      cityController.text = city2;
      businessAddressController.text = profileStore2['seller_data']['company_address'] ?? '' ;
      companycontroller.text = profileStore2['seller_data']['store_name'] ?? '' ;
      gstController.text = profileStore2['seller_data']['tax_number'] ?? '' ;
      googleAddressController.text = profileStore2['data']['address'] ?? '' ;
      partnerNumberController.text = profileStore2['seller_data']['partner_number'] ?? '' ;
      partnerNameController.text = profileStore2['seller_data']['partner'] ?? '' ;
      websiteController.text = profileStore2['seller_data']['web_link'] ?? '' ;
      facebookController.text = profileStore2['seller_data']['facebook'] ?? '' ;
      instaController.text = profileStore2['seller_data']['instagram'] ?? '' ;
      linkdinController.text = profileStore2['seller_data']['linkedin'] ?? '' ;
      pincodeController.text = profileStore2['data']['pincode'] ?? '' ;
      areaController.text = profileStore2['data']['area'] ?? '' ;
      cityController.text = profileStore2['data']['city_name'] ?? '' ;

      businessCategory();
      getCountries();

    }
    else {
      print(response.reasonPhrase);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(context: context, text: "My Profile", isTrue: false),
      body: SingleChildScrollView(
        child: SafeArea(
          child:
              Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: TextFormField(

                      controller: nameController,
                      cursorColor: Colors.black,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                       hintText: "Enter Your Name",
                        hintStyle:
                            TextStyle(color: Colors.black26, fontSize: 14),
                        prefixIcon: Icon(Icons.person),
                        prefixIconColor: Colors.black38,
                        labelStyle: TextStyle(color: Colors.black26),
                      ),
                      // validator: (value) {
                      //   if (value == null ||
                      //       value.isEmpty ||
                      //       !RegExp(r'^[a-z || A-Z || 0-9]').hasMatch(value)) {
                      //     return 'This value is required';
                      //   }
                      //   return null;
                      // },
                    ),
                  ),
                  Container(
                    // margin: EdgeInsets.all(5),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 5, left: 30, bottom: 5, right: 30),
                      child: TextFormField(
                        controller: emailController,
                        cursorColor: Colors.black,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          // enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black26),),
                          // focusedBorder: UnderlineInputBorder(borderSide:BorderSide(color: Colors.black26),),
                          hintText: "Enter Your Email",
                          hintStyle:
                              TextStyle(color: Colors.black26, fontSize: 14),
                          prefixIcon: Icon(Icons.email_outlined),
                          prefixIconColor: Colors.black38,
                          labelStyle: TextStyle(color: Colors.black26),
                        ),
                        // validator: (value) {
                        //   if (value == null ||
                        //       value.isEmpty ||
                        //       !RegExp(r'^[a-z || A-Z]').hasMatch(value)) {
                        //     return 'This value is required';
                        //   }
                        //   return null;
                        // },
                      ),
                    ),
                  ),

                  Container(
                    // margin: EdgeInsets.all(5),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: TextFormField(
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        controller: mobileController,
                        cursorColor: Colors.black,
                        decoration: const InputDecoration(
                          counterText: "",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person),
                          // enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black26),),
                          // focusedBorder: UnderlineInputBorder(borderSide:BorderSide(color: Colors.black26),),
                          hintText: "Enter Your Mobile",
                          hintStyle:
                              TextStyle(color: Colors.black26, fontSize: 14),
                          prefixIconColor: Colors.black38,
                          labelStyle: TextStyle(color: Colors.black26),
                        ),
                        // validator: (value) {
                        //   if (value == null ||
                        //       value.isEmpty ||
                        //       value.length<10) {
                        //     return 'This value is required';
                        //   }
                        //   return null;
                        // },
                        // inputFormatters: <TextInputFormatter>[
                        //   LengthLimitingTextInputFormatter(10),
                        //   FilteringTextInputFormatter.allow(
                        //     RegExp(r'[0-9{10}]'),
                        //   ),
                        //   FilteringTextInputFormatter.digitsOnly
                        // ],
                      ),
                    ),
                  ),

                  Container(
                    // margin: EdgeInsets.all(5),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 5, left: 30, bottom: 5, right: 30),
                      child: TextFormField(
                        controller: companycontroller,
                        cursorColor: Colors.black,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          // enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black26),),
                          // focusedBorder: UnderlineInputBorder(borderSide:BorderSide(color: Colors.black26),),
                          hintText: "Company Name",
                          hintStyle:
                              TextStyle(color: Colors.black26, fontSize: 14),
                          prefixIcon: Icon(Icons.person),
                          prefixIconColor: Colors.black38,
                          labelStyle: TextStyle(color: Colors.black26),
                        ),
                        // validator: (value) {
                        //   if (value == null ||
                        //       value.isEmpty ||
                        //       !RegExp(r'^[a-z || A-Z]').hasMatch(value)) {
                        //     return 'This value is required';
                        //   }
                        //   return null;
                        // },
                      ),
                    ),
                  ),
                  // email
                  Container(
                    child: Padding(
                      padding: EdgeInsets.only(left: 30, bottom: 2, right: 30),
                      child: TextFormField(
                        controller: businessAddressController,
                        cursorColor: Colors.black,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Business Address',
                          hintStyle: TextStyle(color: Colors.black26, fontSize: 14),
                          prefixIcon: Icon(Icons.location_on),
                          prefixIconColor: Colors.black38,
                          labelStyle: TextStyle(color: Colors.black26),
                        ),
                        // validator: (value) {
                        //   if (value == null ||
                        //       value.isEmpty ||
                        //       !RegExp(r'^[a-z || A-Z || 0-9]').hasMatch(value)) {
                        //     return 'This value is required';
                        //   }
                        //   return null;
                        // },
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding:
                          EdgeInsets.only(top: 2, left: 30, bottom: 2, right: 30),
                      child: TextFormField(
                        controller: gstController,
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),

                          // enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black26),),
                          // focusedBorder: UnderlineInputBorder(borderSide:BorderSide(color: Colors.black26),),
                          hintText: 'GST Number(Optional)',
                          hintStyle:
                              TextStyle(color: Colors.black26, fontSize: 14),
                          prefixIcon: Icon(Icons.list_alt_outlined),
                          prefixIconColor: Colors.black38,
                          labelStyle: TextStyle(color: Colors.black26),
                        ),
                        // validator: (value) {
                        //   if (value == null ||
                        //       value.isEmpty ||
                        //       !RegExp(r'^[0-9]').hasMatch(value)) {
                        //     return 'This value is required';
                        //   }
                        //   return null;
                        // },
                        // inputFormatters: <TextInputFormatter>[
                        //   LengthLimitingTextInputFormatter(6),
                        //   FilteringTextInputFormatter.allow(
                        //     RegExp(r'[0-9]'),
                        //   ),
                        //   FilteringTextInputFormatter.digitsOnly
                        // ],
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 2, left: 30, bottom: 2, right: 30),
                      child: TextFormField(

                        controller: udyogController,
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),

                          // enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black26),),
                          // focusedBorder: UnderlineInputBorder(borderSide:BorderSide(color: Colors.black26),),
                          hintText: 'Udyog Number(Optional)',
                          hintStyle:
                              TextStyle(color: Colors.black26, fontSize: 14),
                          prefixIcon: Icon(Icons.phone),
                          prefixIconColor: Colors.black38,
                          labelStyle: TextStyle(color: Colors.black26),
                        ),
                        // validator: (value) {
                        //   if (value == null ||
                        //       value.isEmpty ||
                        //       !RegExp(r'^[0-9]').hasMatch(value)) {
                        //     return 'This value is required';
                        //   }
                        //   return null;
                        // },
                        // inputFormatters: <TextInputFormatter>[
                        //   LengthLimitingTextInputFormatter(6),
                        //   FilteringTextInputFormatter.allow(
                        //     RegExp(r'[0-9]'),
                        //   ),
                        //   FilteringTextInputFormatter.digitsOnly
                        // ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.84,
                    height: MediaQuery.of(context).size.height*0.04,

                    decoration: const BoxDecoration(
                      color: Colors.white,
                      // borderRadius: BorderRadius.circular(10),
                      border: Border(
                          bottom: BorderSide(width: 0.1, color: Colors.grey)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField<String?>(
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 13.5),
                          prefixIcon: Icon(Icons.apps_rounded),
                        ),
                        value: categoryValue,
                        isExpanded: true,
                        icon: Icon(Icons.keyboard_arrow_down),
                        hint: Text(
                          "Bussiness Category",
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                        items: businesscatorymodel?.data?.map((items) {
                          return DropdownMenuItem(
                            value: items.name.toString(),
                            child: Container(child: Text(items.name.toString())),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            categoryValue = newValue;
                            print("selected category $categoryValue");
                          });
                        },
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.84,
                    height: MediaQuery.of(context).size.height*0.04,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      // borderRadius: BorderRadius.circular(10),
                      border: Border(
                          bottom: BorderSide(width: 0.1, color: Colors.grey)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 13.5),
                          prefixIcon: Icon(Icons.business_rounded),
                        ),
                        value: countryValue,
                        onTap: () {},
                        // underline: Container(),
                        isExpanded: true,
                        icon: Icon(Icons.keyboard_arrow_down),
                        hint: Text(
                          "Country",
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                        items: getcountriesmodel?.data?.map((item) {
                          return DropdownMenuItem(
                            value: item.id.toString(),
                            child: Container(child: Text(item.name.toString())),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            countryValue = newValue;
                            stateValue = null ;

                            getState();
                          });
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),
                  Container(
                    width: MediaQuery.of(context).size.width*0.84,
                    height: MediaQuery.of(context).size.height*0.04,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      // borderRadius: BorderRadius.circular(10),
                      border: Border(
                          bottom: BorderSide(width: 0.1, color: Colors.grey)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 13.5),
                          prefixIcon: Icon(Icons.holiday_village),
                        ),
                        value: stateValue,
                        // underline: Container(),
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        hint: Text(
                          "State",
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                        items: getStateModel?.data?.map((item) {
                          return DropdownMenuItem(
                            value: item.id.toString(),
                            child: Container(child: Text(item.name.toString())),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            stateValue = newValue;
                            print("select stateee $stateValue");
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    child: Padding(
                      padding:
                          EdgeInsets.only(top: 6, left: 30, bottom: 2, right: 30),
                      child: TextFormField(
                        controller: districtController,
                        cursorColor: Colors.black,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          // enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black26),),
                          // focusedBorder: UnderlineInputBorder(borderSide:BorderSide(color: Colors.black26),),
                          hintText: 'District',
                          hintStyle:
                              TextStyle(color: Colors.black26, fontSize: 14),
                          prefixIcon: Icon(Icons.location_pin),
                          prefixIconColor: Colors.black38,
                          labelStyle: TextStyle(color: Colors.black26),
                        ),
                        // validator: (value) {
                        //   if (value == null ||
                        //       value.isEmpty ||
                        //       !RegExp(r'^[a-z || A-Z ]').hasMatch(value)) {
                        //     return 'This value is required';
                        //   }
                        //   return null;
                        // },
                      ),
                    ),
                  ),

                  Container(
                    child: Padding(
                      padding:
                          EdgeInsets.only(top: 2, left: 30, bottom: 2, right: 30),
                      child: TextFormField(
                        controller: areaController,
                        cursorColor: Colors.black,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),

                          // enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black26),),
                          // focusedBorder: UnderlineInputBorder(borderSide:BorderSide(color: Colors.black26),),
                          hintText: 'Area',
                          hintStyle:
                              TextStyle(color: Colors.black26, fontSize: 14),
                          prefixIcon: Icon(Icons.location_pin),
                          prefixIconColor: Colors.black38,
                          labelStyle: TextStyle(color: Colors.black26),
                        ),
                        // validator: (value) {
                        //   if (value == null ||
                        //       value.isEmpty ||
                        //       !RegExp(r'^[a-z || A-Z || 0-9]').hasMatch(value)) {
                        //     return 'This value is required';
                        //   }
                        //   return null;
                        // },
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding:
                          EdgeInsets.only(top: 2, left: 30, bottom: 2, right: 30),
                      child: TextFormField(
                        maxLength: 6,
                        controller: pincodeController,
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.black,
                        decoration: const InputDecoration(
                          counterText: "",
                          border: OutlineInputBorder(),
                          // enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black26)),
                          // focusedBorder: UnderlineInputBorder(borderSide:BorderSide(color: Colors.black26)),
                          hintText: 'Pin code',
                          hintStyle:
                              TextStyle(color: Colors.black26, fontSize: 14),
                          prefixIcon: Icon(Icons.lock),
                          prefixIconColor: Colors.black38,
                          labelStyle: TextStyle(color: Colors.black26),
                        ),
                        // validator: (value) {
                        //   if (value == null ||
                        //       value.isEmpty ||
                        //       !RegExp(r'^[0-9]{6}').hasMatch(value)) {
                        //     return 'This value is required';
                        //   }
                        //   return null;
                        // },
                        // inputFormatters: <TextInputFormatter>[
                        //   LengthLimitingTextInputFormatter(6),
                        //   FilteringTextInputFormatter.allow(
                        //     RegExp(r'[0-9]'),
                        //   ),
                        //   FilteringTextInputFormatter.digitsOnly
                        // ],
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding:
                          EdgeInsets.only(top: 2, left: 30, bottom: 2, right: 30),
                      child: TextFormField(
                        controller: cityController,
                        cursorColor: Colors.black,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),

                          // enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black26)),
                          // focusedBorder: UnderlineInputBorder(borderSide:BorderSide(color: Colors.black26)),
                          hintText: 'City',
                          hintStyle:
                              TextStyle(color: Colors.black26, fontSize: 14),
                          prefixIcon: Icon(Icons.location_off_rounded),
                          prefixIconColor: Colors.black38,
                          labelStyle: TextStyle(color: Colors.black26),
                        ),
                        // validator: (value) {
                        //   if (value == null ||
                        //       value.isEmpty ||
                        //       !RegExp(r'^[a-z || A-Z]').hasMatch(value)) {
                        //     return 'This value is required';
                        //   }
                        //   return null;
                        // },
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.only(top: 2, left: 30, bottom: 2, right: 30),
                      child: TextFormField(
                        controller: partnerNameController,
                        cursorColor: Colors.black,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          // enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black26),),
                          // focusedBorder: UnderlineInputBorder(borderSide:BorderSide(color: Colors.black26),),
                          hintText: 'Partner Name',
                          hintStyle:
                              TextStyle(color: Colors.black26, fontSize: 14),
                          prefixIcon: Icon(Icons.person),
                          prefixIconColor: Colors.black38,
                          labelStyle: TextStyle(color: Colors.black26),
                        ),
                        // validator: (value) {
                        //   if (value == null ||
                        //       value.isEmpty ||
                        //       !RegExp(r'^[a-z || A-Z]').hasMatch(value)) {
                        //     return 'This value is required';
                        //   }
                        //   return null;
                        // },
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding:
                          EdgeInsets.only(top: 2, left: 30, bottom: 2, right: 30),
                      child: TextFormField(
                        controller: partnerNumberController,
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.black,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),

                          // enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black26),),
                          // focusedBorder: UnderlineInputBorder(borderSide:BorderSide(color: Colors.black26),),
                          hintText: 'Partner Number',
                          hintStyle:
                              TextStyle(color: Colors.black26, fontSize: 14),
                          prefixIcon: Icon(Icons.call),
                          prefixIconColor: Colors.black38,
                          labelStyle: TextStyle(color: Colors.black26),
                        ),
                        // validator: (value) {
                        //   if (value == null ||
                        //       value.isEmpty ||
                        //       !RegExp(r'^[0-9]').hasMatch(value)) {
                        //     return 'This value is required';
                        //   }
                        //   return null;
                        // },
                        // inputFormatters: <TextInputFormatter>[
                        //   LengthLimitingTextInputFormatter(6),
                        //   FilteringTextInputFormatter.allow(
                        //     RegExp(r'[0-9]'),
                        //   ),
                        //   FilteringTextInputFormatter.digitsOnly
                        // ],
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 2, left: 30, bottom: 2, right: 30),
                      child: TextFormField(
                        controller: googleAddressController,
                        cursorColor: Colors.black,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),

                          // enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black26),),
                          // focusedBorder: UnderlineInputBorder(borderSide:BorderSide(color: Colors.black26),),
                          hintText: 'Google Address',
                          hintStyle:
                              TextStyle(color: Colors.black26, fontSize: 14),
                          prefixIcon: Icon(Icons.location_on),
                          prefixIconColor: Colors.black38,
                          labelStyle: TextStyle(color: Colors.black26),
                        ),
                        // validator: (value) {
                        //   if (value == null ||
                        //       value.isEmpty ||
                        //       !RegExp(r'^[a-z || A-Z]').hasMatch(value)) {
                        //     return 'This value is required';
                        //   }
                        //   return null;
                        // },
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding:
                          EdgeInsets.only(top: 2, left: 30, bottom: 2, right: 30),
                      child: TextFormField(
                        maxLength: 10,
                        controller: anyController,
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.black,
                        decoration: const InputDecoration(
                          counterText: "",
                          border: OutlineInputBorder(),

                          // enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black26),),
                          // focusedBorder: UnderlineInputBorder(borderSide:BorderSide(color: Colors.black26),),
                          hintText: 'Any Other Number',
                          hintStyle:
                              TextStyle(color: Colors.black26, fontSize: 14),
                          prefixIcon: Icon(Icons.call),
                          prefixIconColor: Colors.black38,
                          labelStyle: TextStyle(color: Colors.black26),
                        ),
                        // validator: (value) {
                        //   if (value == null ||
                        //       value.isEmpty ||
                        //       !RegExp(r'^[0-9]').hasMatch(value)) {
                        //     return 'This value is required';
                        //   }
                        //   return null;
                        // },
                        // inputFormatters: <TextInputFormatter>[
                        //   LengthLimitingTextInputFormatter(6),
                        //   FilteringTextInputFormatter.allow(
                        //     RegExp(r'[0-9]'),
                        //   ),
                        //   FilteringTextInputFormatter.digitsOnly
                        // ],
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding:
                          EdgeInsets.only(top: 2, left: 30, bottom: 2, right: 30),
                      child: TextFormField(
                        controller: websiteController,
                        cursorColor: Colors.black,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),

                            // enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black26),),
                            // focusedBorder: UnderlineInputBorder(borderSide:BorderSide(color: Colors.black26),),
                            hintText: 'Enter Website Link',
                            hintStyle:
                                TextStyle(color: Colors.black26, fontSize: 14),
                            prefixIcon: Icon(Icons.link),
                            prefixIconColor: Colors.black38,
                            labelStyle: TextStyle(color: Colors.black26),
                          //  labelText: 'Website Page Link (Optional)'
                        ),

                        // validator: (value) {
                        //   if (value == null ||
                        //       value.isEmpty ||
                        //       !RegExp(r'^[a-z || A-Z]').hasMatch(value)) {
                        //     return 'This value is required';
                        //   }
                        //   return null;
                        // },
                      ),
                    ),
                  ),
//facebook link
                  Container(
                    child: Padding(
                      padding:
                          EdgeInsets.only(top: 2, left: 30, bottom: 2, right: 30),
                      child: TextFormField(
                        controller: facebookController,
                        cursorColor: Colors.black,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),

                          // enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black26),),
                          // focusedBorder: UnderlineInputBorder(borderSide:BorderSide(color: Colors.black26),),
                          hintText: 'Paste here facebook page link',
                          hintStyle:
                              TextStyle(color: Colors.black26, fontSize: 14),
                          prefixIcon: Icon(Icons.facebook),
                          prefixIconColor: Colors.black38,
                          labelStyle: TextStyle(color: Colors.black26),
                          //labelText: 'Facebook Page Link (Optional)'
                        ),
                        // validator: (value) {
                        //   if (value == null ||
                        //       value.isEmpty ||
                        //       !RegExp(r'^[a-z || A-Z]').hasMatch(value)) {
                        //     return 'This value is required';
                        //   }
                        //   return null;
                        // },
                      ),
                    ),
                  ),
//Instagram page link
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 2, left: 30, bottom: 2, right: 30),
                      child: TextFormField(
                        controller: instaController,
                        cursorColor: Colors.black,
                        decoration: const InputDecoration(
                         border: OutlineInputBorder(),
                          // focusedBorder: UnderlineInputBorder(
                          //   borderSide:
                          //   BorderSide(color: Colors.black26),
                          // ),
                          hintText: '  Paste here Instagram page link',
                          hintStyle: TextStyle(
                              color: Colors.black26, fontSize: 14),
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: ImageIcon(AssetImage(
                              'Images/instagram.png',
                            )),
                          ),
                          prefixIconConstraints: BoxConstraints(
                            minWidth: 20,
                            maxHeight: 20,
                          ),
                          prefixIconColor: Colors.black38,

                          labelStyle: TextStyle(
                              color: colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        ),

                        /*validator: (value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          !RegExp(r'^[a-z || A-Z]')
                                              .hasMatch(value)) {
                                        return 'This value is required';
                                      }
                                      return null;
                                    },*/
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 2, left: 30, bottom: 2, right: 30),
                      child: TextFormField(
                        controller: linkdinController,
                        cursorColor: Colors.black,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.only(left: 20),
                          // focusedBorder: UnderlineInputBorder(
                          //   borderSide:
                          //   BorderSide(color: Colors.black26),
                          // ),
                          hintText: 'Paste here Instagram page link',
                          hintStyle: TextStyle(
                              color: Colors.black26, fontSize: 14),
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: ImageIcon(AssetImage(
                              'Images/in2.png',
                            )),
                          ),
                          prefixIconConstraints: BoxConstraints(
                            minWidth: 20,
                            maxHeight: 20,
                          ),
                          prefixIconColor: Colors.black38,

                          labelStyle: TextStyle(
                              color: colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        ),

                        /*validator: (value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          !RegExp(r'^[a-z || A-Z]')
                                              .hasMatch(value)) {
                                        return 'This value is required';
                                      }
                                      return null;
                                    },*/
                      ),
                    ),
                  ),

                /*  Container(
                    child: Padding(
                      padding:
                          EdgeInsets.only(top: 2, left: 39, bottom: 2, right: 30),
                      child: TextFormField(
                        controller: linkdinController,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Paste here linkedin page link',
                            hintStyle:
                                TextStyle(color: Colors.black26, fontSize: 14),
                            prefixIcon: Opacity(
                                opacity: 0.4,
                                child: Image.asset('Images/in2.png')),
                            // prefixIconConstraints:
                            //     BoxConstraints(maxHeight: 20, maxWidth: 20),
                            labelStyle: TextStyle(color: Colors.black26)),
                        // validator: (value) {
                        //   if (value == null ||
                        //       value.isEmpty ||
                        //       !RegExp(r'^[a-z || A-Z]').hasMatch(value)) {
                        //     return 'This value is required';
                        //   }
                        //   return null;
                        // },
                      ),
                    ),
                  ),*/

                  // Container(
                  //     width: 300,
                  //     height: 60,
                  //     child: TextFormField(
                  //       controller: nameController,
                  //       decoration: InputDecoration(
                  //         border: OutlineInputBorder(),
                  //         prefixIcon: Icon(Icons.person),
                  //       ),
                  //     )),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // Container(
                  //   width: 300,
                  //   height: 60,
                  //   decoration:
                  //       BoxDecoration(borderRadius: BorderRadius.circular(40)),
                  //   child: TextFormField(
                  //     controller: emailController,
                  //     decoration: InputDecoration(
                  //       border: OutlineInputBorder(),
                  //       prefixIcon: Icon(Icons.mail),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // Container(
                  //   width: 300,
                  //   height: 60,
                  //   child: TextFormField(
                  //     controller: mobileController,
                  //     decoration: InputDecoration(
                  //       border: OutlineInputBorder(),
                  //       fillColor: Colors.grey,
                  //       focusColor: Colors.grey,
                  //       prefixIcon: Icon(Icons.phone),
                  //     ),
                  //   ),
                  // ),

                  // Container(
                  //   child: Padding(
                  //     padding:  EdgeInsets.only(top: 2,left: 30,bottom: 2,right: 30),
                  //     child: TextFormField(
                  //      // controller: linkdinController,
                  //       cursorColor:  Colors.black,
                  //       decoration: InputDecoration(
                  //           border: OutlineInputBorder(),
                  //           // enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black26),),
                  //           // focusedBorder: UnderlineInputBorder(borderSide:BorderSide(color: Colors.black26),),
                  //           hintText: '    Paste here linkedin page link',
                  //           hintStyle: TextStyle(color: Colors.black26,fontSize: 14),
                  //           prefixIcon:Opacity(opacity: 0.4,
                  //               child:Image.asset('Images/in2.png')),
                  //           prefixIconConstraints: BoxConstraints(maxHeight: 20,maxWidth: 20),
                  //           // labelText: '     Linkedin Page Link (Optional)',
                  //           labelStyle: TextStyle(color: Colors.black26)
                  //       ),
                  //       validator: (value) {
                  //         if (value == null || value.isEmpty || !RegExp(r'^[a-z || A-Z]').hasMatch(value)) {
                  //           return 'This value is required';
                  //         }
                  //         return null;
                  //       },
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(
                    height: 50,
                  ),
                  isLoading ? Center(child: CircularProgressIndicator(color: colors.primary,),) :  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   const SnackBar(content: Text('Processing Data')),
                          // );
                          updateProfile();
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              colors.primary)), //
                      child: const Text(
                        "Update Profile",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

bool isLoading = false ;
  updateProfile() async {
    setState(() {
      isLoading = true ;
    });
    var headers = {
      'Cookie': 'ci_session=7d8842717106efe13f2ff02a20fcadb46425ce54'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            '${baseUrl}update_user'));
    request.fields.addAll({
      'id': userId.toString(),
      'name': nameController.text,
      'mobile': mobileController.text,
      'email': emailController.text,
      'address': googleAddressController.text,
      'user_name': nameController.text,
      'user_mobile': mobileController.text,
      'store_name': companycontroller.text,
      'tax_name': gstController.text,
      'tax_number': gstController.text,
      'company_address': businessAddressController.text,
      'udyog_num': udyogController.text,
      'other_number': anyController.text,
      'partner': partnerNameController.text,
      'partner_number': partnerNumberController.text,
      'facebook': facebookController.text,
      'instagram': instaController.text,
      'linkedin': linkdinController.text,
      'type_of_seller': "${categoryValue}",
      'state': "${stateValue}",
      'destrict': districtController.text,
      'city': cityController.text,
      'area': areaController.text,
      'pincode': pincodeController.text,
      'country': "${countryValue}",
      'google_address': googleAddressController.text,
      'lat': '22.7196',
     'lang': '75.8577'
    });
    print("aaaaaaaaaaaaa${request.fields}");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    Id = sharedPreferences.getString('id');
    sharedPreferences.setString('username', nameController.text);
    sharedPreferences.setString('email', emailController.text);
    sharedPreferences.setString('mobile', mobileController.text);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
 //   print(request.fields);
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false ;
      });
      var finalResult = await response.stream.bytesToString();
      print(finalResult);

      var store2 = jsonDecode(finalResult);

      // print("${finalResult}");
     // final jsonResponse = UserUpdatemodel.fromJson(json.decode(finalResult));
     // Navigator.push(context, MaterialPageRoute(builder: (context) => B2BHome()));
      Fluttertoast.showToast(msg: store2['message']);
      Navigator.pop(context);

    } else {
      print(response.reasonPhrase);
    }
  }
}
