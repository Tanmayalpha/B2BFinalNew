import 'dart:convert';
import 'dart:io';
import 'package:b2b/Constant/Constants.dart';
import 'package:b2b/Model/businessCategoruModel.dart';
import 'package:b2b/Screen/HomeScreen.dart';
import 'package:b2b/Screen/ProductForm.dart';
import 'package:b2b/apiServices/apiConstants.dart';
import 'package:b2b/apiServices/apiStrings.dart';
import 'package:b2b/widgets/appButton.dart';
import 'package:b2b/widgets/multi_select_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';

import 'package:geolocator/geolocator.dart';

import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../Model/GetCountriesModel.dart';
import '../Model/GetStateModel.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../color.dart';

var jsonData;
var store;

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
TextEditingController patnerAddressController = TextEditingController();
TextEditingController anyController = TextEditingController();
TextEditingController websiteController = TextEditingController();
TextEditingController facebookController = TextEditingController();
TextEditingController instaController = TextEditingController();
TextEditingController linkdinController = TextEditingController();
TextEditingController imageController = TextEditingController();

class DetailPage extends StatefulWidget {
  // const DetailPage({super.key});
  String? userName;
  String? userMobile;
  String? userEmail;

  DetailPage(
      {required this.userName,
        required this.userMobile,
        required this.userEmail});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final _formKey = GlobalKey<FormState>();

  // List items = ['Madhya pradesh', 'Uttar Pradesh', 'Bihar', 'Rajasthan', 'Tamil Nadu',];
  // List items1 = ['Indore', 'Ujjain', 'Gwalior', 'Nashik', 'Bhopal',];
  // List items2 = ['Bhawarkua', 'Malwa Mill', 'Railway Statition', 'VijayNagar', 'L.I.G',];

  String? categoryValue;
  Future<void> onTapCall2() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('countryValue',countryValue1!);
    print('Selected Statelllllllllllll${countryValue}');

  }
  String? countryValue1;
  StateData? stateValue;
  CityData? countryValue;
  Position? currentLocation;
  String? _currentAddress;
  static final RegExp nameRegExp = RegExp('[a-zA-Z]');
  // or RegExp(r'\p{L}'); // see https://stackoverflow.com/questions/3617797/regex-to-match-only-letters
  static final RegExp numberRegExp = RegExp(r'\d');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserCurrentLocation();
    getCurrentLoc();
    getCountries();
    Future.delayed(Duration(milliseconds: 400), () {
      return businessCategory();
    });

  }


  Future getUserCurrentLocation() async {
    var status = await Permission.location.request();
    if (status.isDenied) {
      Fluttertoast.showToast(msg: "Permision is requiresd");
    } else if (status.isGranted) {
      await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high)
          .then((position) {
        if (mounted)
          setState(() {
            currentLocation = position;
            homelat = currentLocation?.latitude;
            homeLong = currentLocation?.longitude;
          });
      });
      print("LOCATION===" + currentLocation.toString());
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }
  String? latitude, longitude, state, country;
  Future<void> getCurrentLoc() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    latitude = position.latitude.toString();
    longitude = position.longitude.toString();
    print("LAT$latitude");

    List<Placemark> placemark = await placemarkFromCoordinates(
        double.parse(latitude!), double.parse(longitude!),
        localeIdentifier: "en");

    state = placemark[0].administrativeArea;
    country = placemark[0].country;
    // pincode = placemark[0].postalCode;
    // address = placemark[0].name;
    if (mounted) {
      setState(() {
        // pincodeC!.text = pincode!;
        // addressC!.text = address!;
      });
    }
  }
  BusinessCategoruModel? businesscatorymodel;
  Future<void> businessCategory() async {
    apiBaseHelper.getAPICall(getBusinessCategory).then((getData) {
      bool error = getData['error'];
      if (!error) {
        businesscatorymodel = BusinessCategoruModel.fromJson(getData);
      } else {}
    });
  }

  String? country_id;
  GetCountriesModel? getcountriesmodel;
  GetStateModel? getStateModel;

  File? file;

  Future<void> getCountries() async {
    print("object");
    apiBaseHelper.getAPICall(getCountry).then((getData) {
      bool error = getData['error'];
      if (!error) {
        setState(() {
          getcountriesmodel = GetCountriesModel.fromJson(getData);
        });
      }
    });
  }

  Future<void> getState() async {
    var parameter = {"country_id": countryValue?.id};

    apiBaseHelper.postAPICall(getSate, parameter).then((getData) {
      bool error = getData['error'];
      if (!error) {
        setState(() {
          getStateModel = GetStateModel.fromJson(getData);
        });
      }
    });
  }



  // final ImagePicker _imagePicker = ImagePicker() ;

  Future<void> chooseImage(type) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      file = File(result.files.single.path ?? '');
      imageController.text = result.files.single.name ?? '';
    } else {
      // User canceled the picker
    }

    /* if (type == "Camera") {
      image = await _imagePicker.pickImage(source: ImageSource.camera, imageQuality: 10);
    } else {
      image = await _imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 25);
    }
    if (image != null) {
      setState(() {

        imageController.text = image?.name ?? '' ;

       // base64Image = base64Encode(selectedImage!.readAsBytesSync());
      });
    }*/
  }

  String? _filePath;

  Future<void> _pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      print("hjhjhjhjh ${result.files.single.path.runtimeType} ${result.files.single.path}");
      setState(() {
        // imageFile = result.files.single.path;
        imageFile = File( result.files.single.path ??"");
      });
    }
  }

  Future<void> _showPdfAlert() async {
    if (_filePath != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('PDF Viewer'),
            content: Container(
              width: double.infinity,
              height: 300, // Set the desired height
              child: PDFView(
                filePath: _filePath!,
                onPageChanged: (int? page, int? totalPages) {},
                onViewCreated: (PDFViewController pdfViewController) {},
                onRender: (int? pages) {},
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  showExitPopup1();
                },
                child: const Text('Close'),
              ),
            ],
          );
        },
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.asset('Images/bg-4.png'),
                    // Positioned(
                    //   top: 20,
                    //   left: 80,
                    //   child:  Padding(
                    //     padding: const EdgeInsets.only(top: 10),
                    //     child: Center(child: Image.asset("Images/loginlogo.png",scale: 3,)),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 25, right: 25, bottom: 300, top: 100),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          const BorderRadius.all(Radius.circular(30)),
                          boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.9)),
                          ],
                          border:
                          Border.all(color: Theme.of(context).focusColor),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 30),
                                child: Text(
                                  'Business Details',
                                  style: TextStyle(
                                    color: colors.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),

                              Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 30, bottom: 2, right: 30),
                                  child: select()),
                              Container(
                                margin: const EdgeInsets.all(5),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 0, left: 25, bottom: 2, right: 30),
                                  child: TextFormField(
                                    // validator: (value) => value!.isEmpty
                                    //     ? 'Enter Your Name'
                                    //     : (nameRegExp.hasMatch(value)
                                    //     ? null
                                    //     : 'Enter a Valid Name'),
                                    controller: companycontroller,
                                    cursorColor: Colors.black26,
                                    decoration: const InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.black26),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.black26),
                                      ),
                                      hintText: 'Business Name',
                                      hintStyle: TextStyle(
                                          color: Colors.black26, fontSize: 14),
                                      prefixIcon: Icon(Icons.person),
                                      prefixIconColor: Colors.black38,
                                      labelStyle:
                                      TextStyle(color: Colors.black26),
                                    ),

                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return "Business Name cannot be empty";
                                      } else if(val.length < 3){
                                        return "Please enter must 3 digit Business Name";

                                      }
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 2, left: 30, bottom: 2, right: 30),
                                child: TextFormField(
                                  controller: businessAddressController,
                                  cursorColor: Colors.black,
                                  decoration: const InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black26),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black26),
                                    ),
                                    hintText: 'Business Address',
                                    hintStyle: TextStyle(
                                        color: Colors.black26, fontSize: 14),
                                    prefixIcon: Icon(Icons.location_on),
                                    prefixIconColor: Colors.black38,
                                    labelStyle:
                                    TextStyle(color: Colors.black26),
                                  ),
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return "Business Address cannot be empty";
                                      } else if(val.length < 3){
                                        return "Please enter must 3 digit Business Address";

                                      }
                                    },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 2, left: 30, bottom: 2, right: 30),
                                child: TextFormField(
                                  controller: areaController,
                                  cursorColor: Colors.black,
                                  decoration: const InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black26),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black26),
                                    ),
                                    hintText: 'Area',
                                    hintStyle: TextStyle(
                                        color: Colors.black26, fontSize: 14),
                                    prefixIcon: Icon(Icons.location_pin),
                                    prefixIconColor: Colors.black38,
                                    labelStyle:
                                    TextStyle(color: Colors.black26),
                                  ),
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Area  cannot be empty";
                                    } else if(val.length < 3){
                                      return "Please enter must 3 digit Area";

                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 2, left: 30, bottom: 2, right: 30),
                                child: TextFormField(
                                  controller: cityController,
                                  cursorColor: Colors.black,
                                  decoration: const InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.black26)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.black26)),
                                    hintText: 'City',
                                    hintStyle: TextStyle(
                                        color: Colors.black26, fontSize: 14),
                                    prefixIcon: Icon(Icons.business_rounded),
                                    prefixIconColor: Colors.black38,
                                    labelStyle:
                                    TextStyle(color: Colors.black26),
                                  ),
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "City cannot be empty";
                                    } else if(val.length < 3){
                                      return "Please enter must 3 digit City";

                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 2, left: 30, bottom: 2, right: 30),
                                child: TextFormField(
                                  controller: pincodeController,
                                  keyboardType: TextInputType.number,
                                  cursorColor: Colors.black,
                                  decoration: const InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.black26)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.black26)),
                                    hintText: 'Pin code',
                                    hintStyle: TextStyle(
                                        color: Colors.black26, fontSize: 14),
                                    prefixIcon: Icon(Icons.lock),
                                    prefixIconColor: Colors.black38,
                                    labelStyle:
                                    TextStyle(color: Colors.black26),
                                  ),
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Pin code cannot be empty";
                                    } else if(val.length < 6){
                                      return "Please enter must 6 digit Pin Code";

                                    }
                                  },
                                  inputFormatters: <TextInputFormatter>[
                                    LengthLimitingTextInputFormatter(6),
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]'),
                                    ),
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 2, left: 30, bottom: 2, right: 30),
                                child: TextFormField(
                                  controller: districtController,
                                  cursorColor: Colors.black,
                                  decoration: const InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black26),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black26),
                                    ),
                                    hintText: 'District',
                                    hintStyle: TextStyle(
                                        color: Colors.black26, fontSize: 14),
                                    prefixIcon: Icon(Icons.business_rounded),
                                    prefixIconColor: Colors.black38,
                                    labelStyle:
                                    TextStyle(color: Colors.black26),
                                  ),
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "District cannot be empty";
                                    } else if(val.length < 3){
                                      return "Please enter must 3 digit District";

                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 1.4,
                                height: 35,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  // borderRadius: BorderRadius.circular(10),
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 0.1, color: Colors.grey)),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButtonFormField<CityData>(
                                    decoration: const InputDecoration(
                                      contentPadding:
                                      EdgeInsets.only(bottom: 13.5),
                                      prefixIcon: Icon(Icons.business_rounded),
                                    ),
                                    value: countryValue,
                                    // underline: Container(),
                                    isExpanded: true,
                                    icon: const Icon(Icons.keyboard_arrow_down,
                                        color: Colors.grey),
                                    hint: Text(
                                      "Country",
                                      style: TextStyle(color: Colors.grey[400]),
                                    ),
                                    items: getcountriesmodel?.data?.map((item) {
                                      return DropdownMenuItem<CityData>(
                                        value: item,
                                        child: Text(item.name.toString()),
                                      );
                                    }).toList(),
                                    onChanged: (CityData? newValue) {
                                      setState(() {
                                        countryValue = newValue;
                                        stateValue = null;
                                      });
                                      getState();
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 1.4,
                                height: 35,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  // borderRadius: BorderRadius.circular(10),
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 0.1, color: Colors.grey)),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButtonFormField<StateData>(
                                    decoration: const InputDecoration(
                                      contentPadding:
                                      EdgeInsets.only(bottom: 13.5),
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
                                        value: item,
                                        child: Text(item.name.toString()),
                                      );
                                    }).toList(),
                                    onChanged: (StateData? newValue) {
                                      setState(() {
                                        stateValue = newValue;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 25),
                                child: InkWell(
                                  onTap: () {
                                    showExitPopup1();
                                    // if(_filePath != null){
                                    //   // _showPdfAlert();
                                    // }
                                    // else{
                                    //   showExitPopup1();
                                    // }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 0, right: 0, top: 10),
                                    child: Container(
                                      width: double.infinity,
                                      height: imageFile == null ? 50 : 140,
                                      child: imageFile == null
                                          ? Row(
                                        children:  const [
                                          Padding(
                                            padding:
                                            EdgeInsets.only(left: 14, right: 13),
                                            child: Icon(
                                              Icons.business_sharp,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Text(
                                            'Business Broucher (Optional)',
                                            style: TextStyle(
                                                color: colors.black,
                                                fontWeight:
                                                FontWeight.bold,
                                                fontSize: 13),
                                          ),
                                        ],
                                      )
                                          // : _filePath == null?
                                          : Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 20),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: const [
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "Business Broucher (Optional)",
                                                  style: TextStyle(
                                                      color: colors.black,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      fontSize: 13),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                              imageFile?.path.split('.').last.toLowerCase() == 'pdf'  ?
                                              Container(
                                                //width: 200.0,
                                                //height: 120.0,
                                                padding: const EdgeInsets.all(16.0),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children:  [
                                                    const Icon(
                                                      Icons.picture_as_pdf,
                                                      size: 50.0,
                                                      color: Colors.red,
                                                    ),
                                                    const SizedBox(height: 8.0),
                                                    Text(
                                                        ' ${imageFile?.path.split('/').last.toLowerCase()}',
                                                      overflow: TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        fontSize: 16.0,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                                  : ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(10),
                                              child: Image.file(
                                                imageFile!,
                                                height: 100,
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                            // :const SizedBox.shrink()
                                    ),
                                  ),
                                ),
                              ),
                              const Divider(
                                  color: Colors.grey,
                                  indent: 30,
                                  endIndent: 30,
                                  thickness: 1),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 2, left: 30, bottom: 2, right: 30),
                                child: TextFormField(
                                  maxLength: 15,
                                  controller: gstController,
                                  cursorColor: Colors.black,
                                  keyboardType: TextInputType.name,
                                  decoration: const InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black26),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black26),
                                    ),
                                    hintText: 'GST Number(Optional)',
                                    hintStyle: TextStyle(
                                        color: Colors.black26, fontSize: 14),
                                    prefixIcon: Icon(Icons.list_alt_outlined),
                                    prefixIconColor: Colors.black38,
                                    labelStyle:
                                    TextStyle(color: Colors.black26),
                                  ),
                                  // validator: (value) {
                                  //   if (value == null ||
                                  //       value.isEmpty ||
                                  //       !RegExp(r'^[0-9]').hasMatch(value)) {
                                  //     return 'This value is required';
                                  //   }
                                  //   return null;
                                  // },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 2, left: 30, bottom: 2, right: 30),
                                child: TextFormField(
                                  maxLength: 19,
                                  controller: udyogController,
                                  cursorColor: Colors.black,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black26),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black26),
                                    ),
                                    hintText: 'Udyog Number(Optional)',
                                    hintStyle: TextStyle(
                                        color: Colors.black26, fontSize: 14),
                                    prefixIcon: Icon(Icons.list_alt_outlined),
                                    prefixIconColor: Colors.black38,
                                    labelStyle:
                                    TextStyle(color: Colors.black26),
                                  ),
                                  // validator: (value) {
                                  //   if (value == null ||
                                  //       value.isEmpty ||
                                  //       !RegExp(r'^[0-9]').hasMatch(value)) {
                                  //     return 'This value is required';
                                  //   }
                                  //   return null;
                                  // },
                                ),
                              ),
                              /*Container(
                                width: 248,
                                height: 35,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  // borderRadius: BorderRadius.circular(10),
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 0.1, color: Colors.grey)),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButtonFormField<String?>(
                                    decoration: const InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(bottom: 13.5),
                                      prefixIcon: Icon(Icons.apps_rounded),
                                    ),
                                    value: categoryValue,
                                    isExpanded: true,
                                    icon: Icon(Icons.keyboard_arrow_down),
                                    hint: Text(
                                      "Bussiness Category",
                                      style: TextStyle(color: Colors.grey[400]),
                                    ),
                                    items:
                                        businesscatorymodel?.data?.map((items) {
                                      return DropdownMenuItem(
                                        value: items.name.toString(),
                                        child: Container(
                                            child: Text(items.name.toString())),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        categoryValue = newValue;
                                        print(
                                            "selected category $categoryValue");
                                      });
                                    },
                                  ),
                                ),
                              ),*/
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 2, left: 30, bottom: 2, right: 30),
                                child: TextFormField(
                                  maxLength: 10,
                                  controller: anyController,
                                  keyboardType: TextInputType.number,
                                  cursorColor: Colors.black,
                                  decoration: const InputDecoration(
                                    counterText: "",
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black26),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black26),
                                    ),
                                    hintText:
                                    'Any Other Business Number(optional)',
                                    hintStyle: TextStyle(
                                        color: Colors.black26, fontSize: 13
                                    ),
                                    prefixIcon: Icon(Icons.call),
                                    prefixIconColor: Colors.black38,
                                    labelStyle:
                                    TextStyle(color: Colors.black26),
                                  ),
                                  // validator: (value){
                                  //   if(value!.length < 10){
                                  //     return "Please Enter a 10 digit Number";
                                  //   }
                                  // },
                                ),

                              ),

                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 2, left: 30, bottom: 2, right: 30),
                                child: TextFormField(
                                  controller: partnerNameController,
                                  cursorColor: Colors.black,
                                  decoration: const InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black26),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black26),
                                    ),
                                    hintText: 'Partner Name(Optional)',
                                    hintStyle: TextStyle(
                                        color: Colors.black26, fontSize: 14),
                                    prefixIcon: Icon(Icons.person),
                                    prefixIconColor: Colors.black38,
                                    labelStyle:
                                    TextStyle(color: Colors.black26),
                                  ),
                                  // validator: (value) {
                                  //   if (value == null ||
                                  //       value.isEmpty ||
                                  //       !RegExp(r'^[a-z || A-Z]')
                                  //           .hasMatch(value)) {
                                  //     return 'This value is required';
                                  //   }
                                  //   return null;
                                  // },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 2, left: 30, bottom: 2, right: 30),
                                child: TextFormField(
                                  maxLength: 10,
                                  controller: partnerNumberController,
                                  keyboardType: TextInputType.number,
                                  cursorColor: Colors.black,
                                  decoration: const InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black26),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black26),
                                    ),
                                    hintText: 'Partner Number(Optional)',
                                    hintStyle: TextStyle(
                                        color: Colors.black26, fontSize: 14),
                                    prefixIcon: Icon(Icons.call),
                                    prefixIconColor: Colors.black38,
                                    labelStyle:
                                    TextStyle(color: Colors.black26),
                                  ),
                                  // validator: (value) {
                                  //   if (value == null ||
                                  //       value.isEmpty ||
                                  //       !RegExp(r'^[0-9]').hasMatch(value)) {
                                  //     return 'This value is required';
                                  //   }
                                  //   return null;
                                  // },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 2, left: 30, bottom: 2, right: 30),
                                child: TextFormField(
                                  controller: patnerAddressController,
                                  cursorColor: Colors.black,
                                  decoration: const InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black26),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black26),
                                    ),
                                    hintText: 'Partner Address(Optional)',
                                    hintStyle: TextStyle(
                                        color: Colors.black26, fontSize: 14),
                                    prefixIcon: Icon(Icons.location_on),
                                    prefixIconColor: Colors.black38,
                                    labelStyle:
                                    TextStyle(color: Colors.black26),
                                  ),
                                  // validator: (value) {
                                  //   if (value == null ||
                                  //       value.isEmpty ||
                                  //       !RegExp(r'^[a-z || A-Z]')
                                  //           .hasMatch(value)) {
                                  //     return 'This value is required';
                                  //   }
                                  //   return null;
                                  // },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 2, left: 30, bottom: 2, right: 30),
                                child: TextFormField(
                                  onTap: () async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PlacePicker(
                                          apiKey: Platform.isAndroid
                                              ? "AIzaSyDPsdTq-a4AHYHSNvQsdAlZgWvRu11T9pM"
                                              : "AIzaSyDPsdTq-a4AHYHSNvQsdAlZgWvRu11T9pM",
                                          onPlacePicked: (result) {
                                            print(result.formattedAddress);
                                            setState(() {
                                              googleAddressController.text = result.formattedAddress.toString();
                                              homelat = result.geometry!.location.lat;
                                              homeLong = result.geometry!.location.lng;
                                            });
                                            Navigator.of(context).pop();
                                            // distnce();
                                          },
                                          initialPosition: LatLng(currentLocation!.latitude, currentLocation!.longitude),
                                          useCurrentLocation: true,
                                        ),
                                      ),
                                    );


                                  },
                                  controller: googleAddressController,
                                  cursorColor: Colors.black,
                                  decoration: const InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black26),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black26),
                                    ),
                                    hintText: 'Google Address',
                                    hintStyle: TextStyle(
                                        color: Colors.black26, fontSize: 14),
                                    prefixIcon: Icon(Icons.location_on),
                                    prefixIconColor: Colors.black38,
                                    labelStyle:
                                    TextStyle(color: Colors.black26),
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ) {
                                      return 'Google Address is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),


                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 2, left: 30, bottom: 2, right: 30),
                                child: TextFormField(
                                  controller: websiteController,
                                  cursorColor: Colors.black,
                                  decoration: const InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black26),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black26),
                                    ),
                                    hintText: 'Enter Website Link',
                                    hintStyle: TextStyle(
                                        color: Colors.black26, fontSize: 14),
                                    prefixIcon: Icon(Icons.link),
                                    prefixIconColor: Colors.black38,
                                    // labelStyle:
                                    // TextStyle(color: Colors.black26),
                                    labelText: 'Website Page Link (Optional)',
                                    labelStyle: TextStyle(
                                        color: colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13),
                                  ),
                                  // validator: (value) {
                                  //   if (value == null ||
                                  //       value.isEmpty ||
                                  //       !RegExp(r'^[a-z || A-Z]')
                                  //           .hasMatch(value)) {
                                  //     return 'This value is required';
                                  //   }
                                  //   return null;
                                  // },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 2, left: 30, bottom: 2, right: 30),
                                child: TextFormField(
                                  controller: facebookController,
                                  cursorColor: Colors.black,
                                  decoration: const InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black26),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black26),
                                    ),
                                    hintText: 'Paste here facebook page link',
                                    hintStyle: TextStyle(
                                        color: Colors.black26, fontSize: 14),
                                    prefixIcon: Icon(
                                      Icons.facebook,
                                    ),
                                    prefixIconColor: Colors.black38,
                                    labelText: 'Facebook Link (Optional)',
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
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 2, left: 30, bottom: 2, right: 30),
                                child: TextFormField(
                                  controller: instaController,
                                  cursorColor: Colors.black,
                                  decoration: const InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black26),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black26),
                                    ),
                                    hintText: 'Paste here Instagram page link',
                                    hintStyle: TextStyle(
                                        color: Colors.black26, fontSize: 14),
                                    prefixIcon: ImageIcon(AssetImage(
                                      'Images/instagram.png',
                                    )),
                                    prefixIconConstraints: BoxConstraints(
                                      minWidth: 50,
                                      maxHeight: 20,
                                    ),
                                    prefixIconColor: Colors.black38,
                                    labelText: 'Instagram page link(Optional)',
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
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 2, left: 30, bottom: 2, right: 30),
                                child: TextFormField(
                                  controller: linkdinController,
                                  cursorColor: Colors.black,
                                  decoration: const InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black26),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black26),
                                    ),
                                    hintText: 'Paste here linkedin page link',
                                    hintStyle: TextStyle(
                                        color: Colors.black26, fontSize: 14),
                                    prefixIcon: ImageIcon(AssetImage(
                                      'Images/in2.png',
                                    )),
                                    prefixIconConstraints: BoxConstraints(
                                      minWidth: 50,
                                      maxHeight: 20,
                                    ),
                                    prefixIconColor: Colors.black38,
                                    labelText: 'linkedin page link(Optional)',
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
                              // Padding(
                              //   padding: const EdgeInsets.only(
                              //       top: 2, left: 30, bottom: 2, right: 30),
                              //   child: TextFormField(
                              //     controller: imageController,
                              //     cursorColor: Colors.black,
                              //     readOnly: true,
                              //     onTap: (){
                              //       chooseImage('');
                              //     },
                              //     decoration: const InputDecoration(
                              //         enabledBorder: UnderlineInputBorder(
                              //           borderSide:
                              //           BorderSide(color: Colors.black26),
                              //         ),
                              //         focusedBorder: UnderlineInputBorder(
                              //           borderSide:
                              //           BorderSide(color: Colors.black26),
                              //         ),
                              //         hintText: 'Choose File',
                              //         hintStyle: TextStyle(
                              //             color: Colors.black26, fontSize: 14),
                              //         prefixIcon: Icon(Icons.file_copy_outlined),
                              //         prefixIconColor: Colors.black38,
                              //         labelStyle:
                              //         TextStyle(color: Colors.black26),
                              //         labelText:
                              //         'Business Brochure'),
                              //     validator: (value) {
                              //       if (value == null ||
                              //           value.isEmpty ||
                              //           !RegExp(r'^[a-z || A-Z]')
                              //               .hasMatch(value)) {
                              //         return 'This value is required';
                              //       }
                              //       return null;
                              //     },
                              //   ),
                              // ),
                              const SizedBox(height: 45),
                              Btn(
                                  height: 50,
                                  width: 150,
                                  title: isLoading ? "Please wait...": 'Complete',
                                  onPress: () {
                                    if (_formKey.currentState!.validate()) {
                                      if(results.isEmpty){
                                        final snackBar =
                                        SnackBar(content: Text('Please Select user'));
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      }else{
                                       userRegisterApi(false);
                                      }

                                    }else{
                                      final snackBar =
                                      SnackBar(content: Text('all fields are required'));
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    }
                                  }),
                              const SizedBox(height: 15),
                              isLoading
                                  ? const Center(
                                  child: CircularProgressIndicator(
                                      color: colors.primary))
                                  : Btn(
                                  height: 50,
                                  width: 200,
                                  title: isLoading ? "Please wait...": 'Product Detail Page',
                                  onPress: () {
                                    if (_formKey.currentState!.validate()) {
                                      if(results.isEmpty){
                                        final snackBar =
                                        SnackBar(content: Text('Please Select user'));
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      }else{
                                        userRegisterApi(true);
                                      }
                                    }else{
                                      final snackBar =
                                      SnackBar(content: Text('all fields are required'));
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    }

                                  }),
                              const SizedBox(height: 50),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  File? imageFile;

  Future getImage(ImageSource source, BuildContext context, int i) async {
    var image = await ImagePicker().pickImage(
      source: source,
    );
    setState(() {
      if (i == 1) {
        imageFile = File(image!.path);
      }
    });
    Navigator.pop(context);
  }

  Future getImageCmera(ImageSource source, BuildContext context, int i) async {
    var image = await ImagePicker().pickImage(
      source: source,
    );
    setState(() {
      if (i == 1) {
        imageFile = File(image!.path);
      }
    });
    Navigator.pop(context);
  }

  Future<bool> showExitPopup1() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: const Text('Select Image'),
          content: Row(
            // crossAxisAlignment: CrossAxisAlignment.s,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 30,
                width: 70,
                child: ElevatedButton(
                  onPressed: () {
                    getImage(ImageSource.camera, context, 1);
                  },
                  child: const Text('Camera', style: TextStyle(fontSize: 10),),
                ),
              ),
              const SizedBox(
                width: 11,
              ),
              Container(
                height: 30,
                width: 70,
                child: ElevatedButton(
                  onPressed: () {
                    getImageCmera(ImageSource.gallery, context, 1);
                  },
                  //return true when click on "Yes"
                  child: const Text('Gallery', style: TextStyle(fontSize: 10)),
                ),
              ),
              const SizedBox(
                width: 11,
              ),
              Container(
                height: 30,
                width: 70,
                child: ElevatedButton(
                  onPressed: () {
                    _pickPDF();
                    Navigator.pop(context);
                    // getImageCmera(ImageSource.gallery, context, 1);
                  },
                  //return true when click on "Yes"
                  child: const Text('PDf', style: TextStyle(fontSize: 10),),
                ),
              ),
            ],
          )),
    ) ??
        false; //if showDialouge had returned null, then return false
  }

  bool isLoading = false;

  userRegisterApi(bool isFrom) async {
    setState(() {
      isLoading = true;
    });
    var headers = {
      'Cookie': 'ci_session=60bd1612f8cf649e6e21002891d965ec475c24db'
    };
    var request =
    http.MultipartRequest('POST', Uri.parse('${baseUrl}register'));
    request.fields.addAll({
      'type_of_seller': results.join(','),
      'state': stateValue?.id ?? '',
      'destrict': districtController.text,
      'city': cityController.text,
      'area': areaController.text,
      'pincode': pincodeController.text,
      'country': countryValue?.id ?? '',
      'google_address': googleAddressController.text,
      'lat': homelat.toString(),
      'lang': homeLong.toString(),
      'username': widget.userName ?? '',
      'mobile': widget.userMobile ?? '',
      'email': widget.userEmail ?? '',
      'address': businessAddressController.text,
      'company': companycontroller.text,
      'complete': '1',
    });
    print('____Sasasass______${request.fields}_________');

    if (imageFile != null) {
      request.files.add(
          await http.MultipartFile.fromPath('broucher', imageFile?.path ?? ""));
    }
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();

      print('==============$result');
      var finalResult = jsonDecode(result);
      if (finalResult['error'] == true) {
        setState(() {
          userIdd1 = finalResult['data'].toString();
          print('user id in rigister time=============$userIdd1');
        });

        final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
        sharedPreferences.setString('id', userIdd1);
        Fluttertoast.showToast(
          msg: finalResult['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black54,
          textColor: colors.white,
        );

        if (isFrom) {
          await Future.delayed(const Duration(seconds: 1));
          if (context.mounted)
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const ProductFormScreen()));
        } else {
          await Future.delayed(const Duration(seconds: 1));
          if (context.mounted)
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const B2BHome()));
        }
        companycontroller.clear();
        businessAddressController.clear();
        gstController.clear();
        udyogController.clear();
        businessCategoryController.clear();
        countryController.clear();
        stateController.clear();
        districtController.clear();
        areaController.clear();
        pincodeController.clear();
        cityController.clear();
        partnerNameController.clear();
        partnerNumberController.clear();
        googleAddressController.clear();
        patnerAddressController.clear();
        anyController.clear();
        websiteController.clear();
        facebookController.clear();
        instaController.clear();
        //linkdinController.clear();
        imageController.clear();
        setState(() {
          isLoading = false;
        });
      } else {
        Fluttertoast.showToast(msg: finalResult['message']);
        setState(() {
          isLoading = false;
        });
        print(response.reasonPhrase);
      }
    } else {
      setState(() {
        isLoading = false;
      });
      print(response.reasonPhrase);
    }
  }


  List<String> results = [];

  Widget select() {
    return InkWell(
      onTap: () {
        setState(() {
          _showMultiSelect();
        });
      },
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
            color: colors.white,
            border: Border(
                bottom: BorderSide(color: colors.black.withOpacity(0.5)))),
        child: results.isEmpty
            ? Row(

          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Image.asset("Images/selcectUser.png",height: 15,color: Colors.grey,)
            ),

            // Container(
            //
            //   height: 50,
            //   width: 50,
            //
            //   decoration: BoxDecoration(
            //
            //       color: Colors.black,
            //       image: DecorationImage(image: AssetImage('Images/ic.png'),fit: BoxFit.cover)),
            //
            // ),

            const SizedBox(
              width: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text(
                'Select User',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        )
            : SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: results.map((e) {
              return Padding(
                padding:
                const EdgeInsets.only(top: 10, left: 1, right: 1),
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: colors.primary),
                    child: Center(
                        child: Text(
                          "${e}",
                          style: TextStyle(color: colors.white),
                        ))),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  void _showMultiSelect() async {
    results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return MultiSelect(sellerList: businesscatorymodel?.data);
        });
      },
    );
    setState(() {});
  }
}
