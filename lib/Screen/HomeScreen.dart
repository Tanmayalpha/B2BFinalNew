import 'dart:async';
import 'dart:convert';
import 'dart:math';

// import 'package:anoop/Model/GetHomeCategoryModel.dart';
import 'package:b2b/AuthView/otp_verify.dart';
import 'package:b2b/Model/AdModel.dart';
import 'package:b2b/Model/GetSupplierModel.dart';
import 'package:b2b/Screen/ClientScreen.dart';
import 'package:b2b/Screen/Upadate_product.dart';
import 'package:b2b/Screen/purches_product.dart';
import 'package:b2b/Screen/searchScreen.dart';
import 'package:b2b/apiServices/apiConstants.dart';
import 'package:b2b/utils/design_config.dart';
import 'package:b2b/widgets/appButton.dart';
import 'package:b2b/widgets/categoryCard.dart';
import 'package:b2b/widgets/drawer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:http/http.dart' as http;
import 'package:speech_to_text/speech_to_text.dart';
import 'package:url_launcher/url_launcher.dart';

// import '../Model/GetHomeCategoryModel.dart';
import '../Api.path.dart';
import '../Constant/Constants.dart';
import '../Model/CitySearchModel.dart';
import '../Model/GetCategoryModel.dart';
import '../Model/GetHomeCategoryModel.dart';
import '../Model/GetHomeCategoryModel.dart';
import '../Model/GetHomeProductsModel.dart';
import '../Model/Get_cat_by_product_model.dart';
import '../Model/Home_specific_model.dart';
import '../Model/advertiseModel.dart';
import '../Model/sliderImageModel.dart';
import '../utils/GetPreference.dart';
import 'AboutUs.dart';
import 'Contactus.dart';
import 'EnquiryList.dart';
import 'Help&Support.dart';
import 'MapHomeScreen.dart';
import 'MapScreen.dart';
import 'MyPlanList.dart';
import 'ProductForm.dart';
import 'Product_details_home.dart';
import 'SupplierScreen.dart';
import '../Suggestion/your_suggestion_screen.dart';
import '../color.dart';
import 'Add_Product.dart';
import 'AllCategory.dart';
import 'AllCommunity.dart';
import 'AllProducts.dart';
import 'CommunityScreen.dart';
import 'ComputerDescription.dart';
import 'DescriptionScreen.dart';
import 'FAQ.dart';
import 'FurnitrureDescription.dart';
import 'PlanScreen.dart';
import '../StaticScreen/PrivacyPolicy.dart';
import '../StaticScreen/TermandCondition.dart';
import 'get_product_screen.dart';
import '../AuthView/login.dart';
import 'myProfile.dart';
import 'our_activity.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

SliderImageModel? finalImages;
AdModel? adImages;
AdvertiseModel? advertise;

var homelat;
var homeLong;
var result;
var obtainedId;
var obtainedName;
var obtainedEmail;
var obtainedMobile;

var companyName;
var bussinessAddress;
var gstNumber;
var udyogNumber;
var bussinessCategory;
var country;
var state;
var district;
var area;
var pinCode;
var city;
var partnerName;
var partnerNumber;
var googleAddress;
var anyNumber;
var websiteLink;
var facebook;
var insta;
var linkdin;

var imagee;
var namee;
var emaill;
var mobilee;
var companyName2;
var bussinessAddress2;
var gstNumber2;
var udyogNumber2;
var bussinessCategory2;
var country2;
var state2;
var district2;
var area2;
var pinCode2;
var city2;
var partnerName2;
var partnerNumber2;
var googleAddress2;
var anyNumber2;
var websiteLink2;
var facebook2;
var insta2;
var linkdin2;

String? product_name;
String? product_price;
String? product_loc;
String? product_image;
String? userId;
var profileStore2;
City? selectedCity ;

// final SharedPreferences sharedPreferences= SharedPreferences.getInstance() as SharedPreferences;
class B2BHome extends StatefulWidget {
  const B2BHome({Key? key}) : super(key: key);

  // String? name;
  // String? email;
  // String? mobile;
  // B2BHome({required this.name,required this.email,required this.mobile,});
  @override
  State<B2BHome> createState() => _B2BHomeState();
}
// final String? action = sharedPreferences.getString('name');

Future getValidation() async {
  final SharedPreferences sharedPreferences =
  await SharedPreferences.getInstance();
  obtainedId = sharedPreferences.getString('id');
  obtainedName = sharedPreferences.getString('username');
  obtainedEmail = sharedPreferences.getString('email');
  obtainedMobile = sharedPreferences.getString('mobile');
  // companyName=sharedPreferences.getString('mobile');
  bussinessAddress = sharedPreferences.getString('Address');
  gstNumber = sharedPreferences.getString('gstNumber');
  udyogNumber = sharedPreferences.getString('udyogNumber');
  bussinessCategory = sharedPreferences.getString('bussinessCategory');
  country = sharedPreferences.getString('country');
  state = sharedPreferences.getString('state');
  district = sharedPreferences.getString('district');
  area = sharedPreferences.getString('area');
  pinCode = sharedPreferences.getString('pinCode');
  city = sharedPreferences.getString('city');
  partnerName = sharedPreferences.getString('partnerName');
  partnerNumber = sharedPreferences.getString('partnerNumber');
  googleAddress = sharedPreferences.getString('googleAddress');
  facebook = sharedPreferences.getString('facebook');
  insta = sharedPreferences.getString('insta');
  linkdin = sharedPreferences.getString('linkdin');
}

class _B2BHomeState extends State<B2BHome> {
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  bool _hasSpeech = false;
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;

  String lastStatus = '';
  String _currentLocaleId = '';
  String lastWords = '';
  final SpeechToText speech = SpeechToText();
  late StateSetter setStater;
  void resultListener(SpeechRecognitionResult result) {
    setStater(
          () {
        lastWords = result.recognizedWords;
        searchC.text = lastWords;
      },
    );

    if (result.finalResult) {
      Future.delayed(const Duration(seconds: 1)).then((_) async {
        // clearAll();

        searchC.text = lastWords;
        searchC.selection = TextSelection.fromPosition(
            TextPosition(offset: searchC.text.length));

        setState(() {});
        Navigator.of(context).pop();
      });
    }
  }
  Future<void> initSpeechState() async {
    var hasSpeech = await speech.initialize(
        onError: errorListener,
        onStatus: statusListener,
        debugLogging: false,
        finalTimeout: const Duration(milliseconds: 0));
    if (hasSpeech) {
      var systemLocale = await speech.systemLocale();
      _currentLocaleId = systemLocale?.localeId ?? '';
    }

    if (!mounted) return;

    setState(() {
      _hasSpeech = hasSpeech;
    });
    if (hasSpeech) showSpeechDialog();
  }
  void errorListener(SpeechRecognitionError error) {}
  void statusListener(String status) {
    setStater(
          () {
        lastStatus = status;
      },
    );
  }
  void startListening() {
    lastWords = '';
    speech.listen(
        onResult: resultListener,
        listenFor: const Duration(seconds: 30),
        pauseFor: const Duration(seconds: 5),
        partialResults: true,
        localeId: _currentLocaleId,
        onSoundLevelChange: soundLevelListener,
        cancelOnError: true,
        listenMode: ListenMode.confirmation);
    setStater(() {});
  }
  showSpeechDialog() {
    return DesignConfiguration.dialogAnimate(
      context,
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setStater1) {
          setStater = setStater1;
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text(
              "Search",
              // getTranslated(context, 'SEarchHint')!,
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
                fontSize: textFontSize16,
                fontFamily: 'ubuntu',
              ),
              textAlign: TextAlign.center,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          blurRadius: .26,
                          spreadRadius: level * 1.5,
                          color: Colors.black
                              .withOpacity(.05))
                    ],
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(
                        Radius.circular(circularBorderRadius50)),
                  ),
                  child: IconButton(
                      icon: const Icon(
                        Icons.mic,
                        color: colors.primary,
                      ),
                      onPressed: () {
                        if (!_hasSpeech) {
                          initSpeechState();
                        } else {
                          !_hasSpeech || speech.isListening
                              ? null
                              : startListening();
                        }
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(lastWords),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  color:
                  Colors.black.withOpacity(0.1),
                  child: Center(
                    child: speech.isListening
                        ? Text(
                      'I\'m listening...',
                      // getTranslated(context, "I'm listening...")!,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(
                          color:
                          Colors.black,
                          fontFamily: 'ubuntu',
                          fontWeight: FontWeight.bold),
                    )
                        : Text(
                      'Not listening',
                      //  getTranslated(context, 'Not listening')!,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(
                        color:
                        Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'ubuntu',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);

    setStater(() {
      this.level = level;
    });
  }
  @override
  void initState() {
    super.initState();
    getProfile();
    searchCityApi();
    getUserId();
    sliderImages();
    getAdvertisgment();
    _getAddressFromLatLng();
    getUserCurrentLocation();
    getCatByProductApi();
    // TODO: implement initState
    getValidation();
    getSupplier();
    homeCategories();
    homeProducts();
    getSpecifiyApi();
    //_marker.addAll(_list);
    // getUserId();

    print('_____sssssss_____${mNo}_________');
  }
  // Completer<GoogleMapController> _controller =Completer();
  // final CameraPosition _kGoogle= const CameraPosition(
  //   target: LatLng(22.73140, 75.90821),
  //   zoom: 14.4746,
  // );
  // final List<Marker> _marker =[];
  // final List<Marker> _list = const [
  //   Marker(
  //       markerId: MarkerId('1'),
  //       position:  LatLng(22.73140, 75.90821),
  //       infoWindow: InfoWindow(
  //           title: 'Khajrana Ganesh mandir'
  //       )
  //   ),
  //   Marker(
  //       markerId: MarkerId('2'),
  //       position:  LatLng(22.74524188218821, 75.89394531293044),
  //       infoWindow: InfoWindow(
  //           title: 'C21'
  //       )
  //   ),
  //   Marker(
  //       markerId: MarkerId('3'),
  //       position:  LatLng(22.751247256865494, 75.89504445001252),
  //       infoWindow: InfoWindow(
  //           title: 'Vijay nagar'
  //       )
  //   ),
  //   Marker(
  //       markerId: MarkerId('4'),
  //       position:  LatLng(22.747763486587218, 75.93392486766031),
  //       infoWindow: InfoWindow(
  //           title: 'Phonix'
  //       )
  //   ),
  //   Marker(
  //       markerId: MarkerId('5'),
  //       position:  LatLng(22.745063540584127, 75.87830314501237),
  //       infoWindow: InfoWindow(
  //           title: 'Nanda nagar'
  //       )
  //   ),
  //   Marker(
  //       markerId: MarkerId('6'),
  //       position:  LatLng(22.749437698014606, 75.90354121091355),
  //       infoWindow: InfoWindow(
  //           title: 'Radisson Square'
  //       )
  //   ),
  //   Marker(
  //       markerId: MarkerId('7'),
  //       position:  LatLng(22.75457023607151, 75.90358801091365),
  //       infoWindow: InfoWindow(
  //           title: 'Bombay Hospital'
  //       )
  //   ),
  //   Marker(
  //       markerId: MarkerId('8'),
  //       position:  LatLng(22.72528564135569, 75.88389942408358),
  //       infoWindow: InfoWindow(
  //           title: 'New palasiya '
  //       )
  //   ),
  // ];
  TextEditingController searchC = TextEditingController();


  bool isSwitched = false;
  var textValue = 'General';

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      getSpecifiyApi();
      getCategory();
      setState(() {
        isSwitched = true;
        textValue = 'Specific';
      });
    } else {
      setState(() {
        isSwitched = false;
        textValue = 'General';
      });
    }
  }

  String? _currentAddress;
  double lat = 0.0;
  double long = 0.0;
  Position? currentLocation;

  Future getUserCurrentLocation() async {
    var status = await Permission.location.request();
    if (status.isDenied) {
      Fluttertoast.showToast(msg: "Permision is requiresd");
    } else if (status.isGranted) {
      await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high)
          .then((position) {
        if (mounted) {
          setState(() {
            currentLocation = position;
            homelat = currentLocation?.latitude;
            homeLong = currentLocation?.longitude;
          });
        }
      });
      print("LOCATION===" + currentLocation.toString());
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }
  _getAddressFromLatLng() async {
    await getUserCurrentLocation().then((_) async {
      try {
        print("Addressss function");
        List<Placemark> p = await placemarkFromCoordinates(
            currentLocation!.latitude, currentLocation!.longitude);
        Placemark place = p[0];
        setState(() {
          _currentAddress =
          "${place.street}, ${place.subLocality}, ${place.locality}, ${place.country}";
          //"${place.name}, ${place.locality},${place.administrativeArea},${place.country}";
          print("current addresssss nowwwww${_currentAddress}");
        });
      } catch (e) {
        print('errorrrrrrr ${e}');
      }
    });
  }
  // var sessionId;
  GetSupplierModel? getSupplierModel;

  void getUserId() async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    var idd = sharedPreferences.getString('id');
    setState(() {
      userId = idd.toString();
      print('user id in home page==========${userId}');
      print('user id in home page==========${userId.runtimeType}');
    });
  }

  getSupplier() async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    var sessionId = sharedPreferences.getString('id');
    var headers = {
      'Cookie': 'ci_session=bbef05fec3d04e54ce989d212a56be791511d2db'
    };
    var request =
    http.MultipartRequest('POST', Uri.parse('${ApiService.supplier}'));
    request.fields.addAll({'seller_id': '${sessionId}'});
    print("seller id in get supplier ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse =
      GetSupplierModel.fromJson(json.decode(finalResponse));
      print("Get Supplierrrrr");
      setState(() {
        getSupplierModel = jsonResponse;
      });
    } else {
      print(response.reasonPhrase);
    }
  }
  showDialogBox() async {
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.transparent,
              content: Container(
                height: 350,
                // width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 130,
                            decoration: BoxDecoration(
                                color: colors.white,
                                borderRadius: BorderRadius.circular(5)),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SupplierScreen(
                                          nameChange: true,
                                          isManu: "Manufacturers",
                                        )));
                              },
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 90,
                                      width: double.infinity,
                                      child: Image.asset(
                                        "Images/manufacturer.png",
                                        // height: 100,
                                        // width:double.infinity
                                      ),
                                    ),
                                  ),
                                  // Image.asset("Images/Manufacture.png", fit: BoxFit.fill,
                                  //
                                  // ),

                                  const Text(
                                    "Manufacture",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: colors.white,
                                borderRadius: BorderRadius.circular(5)),
                            height: 130,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SupplierScreen(
                                          nameChange: true,
                                          isManu: "Wholesaler",
                                        )));
                              },
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      height: 90,
                                      width: double.infinity,
                                      child: Image.asset(
                                        "Images/Wholesale.png",
                                        // height: 100,
                                        // width:double.infinity
                                      ),
                                    ),
                                  ),
                                  const Text(
                                    "Wholesaler",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: colors.white,
                                borderRadius: BorderRadius.circular(5)),
                            height: 130,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SupplierScreen(
                                          nameChange: true,
                                          isManu: "Retailers",
                                        )));
                              },
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      height: 90,
                                      width: double.infinity,
                                      child: Image.asset(
                                        "Images/Retailers.png",
                                        // height: 100,
                                        // width:double.infinity
                                      ),
                                    ),
                                  ),
                                  const Text(
                                    "Retailers",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: colors.white,
                                borderRadius: BorderRadius.circular(5)),
                            height: 130,
                            child: InkWell(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        height: 90,
                                        width: double.infinity,
                                        child: Image.asset(
                                          "Images/Import - Export.png",
                                          // height: 100,
                                          // width:double.infinity
                                        ),
                                      ),
                                    ),
                                    const Text(
                                      "Import-export",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
                                )),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          });
        });
  }
  TextEditingController pinCodeController = TextEditingController();
  final _Cotact = GlobalKey<FormState>();
  TextEditingController yournamecontroller = TextEditingController();
  TextEditingController yourMobileNumber = TextEditingController();
  TextEditingController YourcityController = TextEditingController();
  String?  cityController ;
  bool verifie = false;
  String? controller;
  String? controllerDelete;
  String? OTPIS;
  sendOtpCotactSuplier(String ProductId) async {
    var headers = {
      'Cookie': 'ci_session=aa35b4867a14620a4c973d897c5ae4ec6c25ee8e'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${baseUrl}send_otp_for_enquiry'));
    if (userId == null || userId == '' || userId == 'null') {
      request.fields.addAll({
        'mobile': yourMobileNumber.text.toString(),
        'city': YourcityController.text.toString(),
        'name': yournamecontroller.text.toString(),
      });
    } else {
      request.fields.addAll({
        'mobile': yourMobileNumber.text.toString(),
      });
    }

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalresult = jsonDecode(result);
      if (finalresult['error'] == false) {
        setState(() {
          verifie = true;

          OTPIS = finalresult['data']['otp'].toString();
        });

        Navigator.pop(context);
        showDialogverifyContactSuplier(ProductId);
      }
    } else {
      print(response.reasonPhrase);
    }
  }
  void showDialogContactSuplier(String productId, Mobile) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.transparent,
              content: Container(
                height: userId == "null" ? 400 : 250,
                width: MediaQuery.of(context).size.width / 1.2,
                // width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 3,
                  child: Form(
                    key: _Cotact,
                    child: Column(
                      children: [
                        Container(
                          color: colors.primary,
                          height: 60,
                          child: Row(
                            children: const [
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Contact Supplier',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        userId != 'null'
                            ? Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10),
                              child: TextFormField(
                                maxLength: 10,
                                readOnly: true,
                                controller: yourMobileNumber,
                                decoration: InputDecoration(
                                  prefixIcon: const Padding(
                                    padding:
                                    EdgeInsets.only(top: 3),
                                    child: Icon(
                                      Icons.call,
                                      color: colors.primary,
                                      size: 20,
                                    ),
                                  ),
                                  counterText: "",
                                  contentPadding:
                                  const EdgeInsets.only(top: 0, left: 0),
                                  hintText: "Your Mobile",
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(5.0),
                                    borderSide: const BorderSide(),
                                  ),
                                ),
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "mobile cannot be empty";
                                  } else if(val.length < 10){
                                    return "Please enter 10 digit number";

                                  }
                                },
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        )
                            : Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10),
                              child: TextFormField(
                                controller: yournamecontroller,
                                decoration: InputDecoration(
                                  contentPadding:
                                  const EdgeInsets.only(top: 5, left: 5),
                                  hintText: "Your Name",
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(5.0),
                                    borderSide: const BorderSide(),
                                  ),
                                ),
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "Name cannot be empty";
                                  } else if(val.length < 3){
                                    return "Please enter 3 digit Name";

                                  }
                                },
                                keyboardType: TextInputType.name,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10),
                              child: TextFormField(
                                maxLength: 10,
                                controller: yourMobileNumber,
                                decoration: InputDecoration(
                                  contentPadding:
                                  const EdgeInsets.only(top: 5, left: 5),
                                  hintText: "Your Mobile",
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(5.0),
                                    borderSide: const BorderSide(),
                                  ),
                                ),
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "mobile cannot be empty";
                                  } else if(val.length < 10){
                                    return "Please enter 10 digit number";

                                  }
                                },
                                keyboardType: TextInputType.name,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10),
                              child: TextFormField(
                                controller: YourcityController,
                                decoration: InputDecoration(
                                  contentPadding:
                                  const EdgeInsets.only(top: 5, left: 5),
                                  hintText: "Your City",
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(5.0),
                                    borderSide: const BorderSide(),
                                  ),
                                ),
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "City cannot be empty";
                                  } else if(val.length < 3){
                                    return "Please enter 3 digit City";

                                  }
                                },
                                keyboardType: TextInputType.name,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // GoogleMap(
                        //   onMapCreated: (GoogleMapController controller){_controller.complete(controller);},
                        //   initialCameraPosition: _kGoogle,
                        //   markers:Set<Marker>.of(_list),
                        //   myLocationEnabled: true,
                        //
                        // ),

                        Btn(
                          height: 40,
                          width: 150,
                          title: "Send OTP",
                          onPress: () {
                            print('__________OTP_________');
                            if (_Cotact.currentState!.validate()) {
                              sendOtpCotactSuplier(productId);
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
        });
  }
  void showDialogverifyContactSuplier(String productIddd) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.transparent,
              content: Container(
                height: 250,
                width: MediaQuery.of(context).size.width / 1.5,
                // width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 3,
                  child: Column(
                    children: [
                      Container(
                        color: colors.primary,
                        height: 60,
                        child: Row(
                          children: const [
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Contact Supplier',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'OTP : ${OTPIS}',
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: OtpTextField(
                              numberOfFields: 4,
                              fieldWidth: 20,
                              borderColor: Colors.red,
                              focusedBorderColor: Colors.blue,
                              showFieldAsBox: false,
                              borderWidth: 1,
                              //runs when a code is typed in
                              onCodeChanged: (String code) {
                                print(code);
                                // pinCodeController.text=code;
                                //  controller=code;
                                //handle validation or checks here if necessary
                              },
                              //runs when every textfield is filled
                              onSubmit: (String verificationCode) {
                                controller = verificationCode;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                      Btn(
                        height: 40,
                        width: 150,
                        title: "Verify OTP",
                        onPress: () {
                          if (controller == OTPIS) {
                            sendEnqury(productIddd);
                          } else {
                            Fluttertoast.showToast(msg: 'Enter Correct OTP');
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }
  Future<void> sendEnqury(String productid) async {
    var headers = {
      'Cookie': 'ci_session=ff1e2af38a215d1057b062b8ff903fc27b0c488b'
    };
    var request =
    http.MultipartRequest('POST', Uri.parse('${baseUrl}save_inquiry'));

    if (userId == null || userId == '' || userId == 'null') {
      request.fields.addAll({
        'name': yournamecontroller.text.toString(),
        'mobile': yourMobileNumber.text.toString(),
        'city': YourcityController.text.toString(),
        'product_id': productid.toString()
      });
    } else {
      request.fields.addAll({
        'mobile': yourMobileNumber.text.toString(),
        'product_id': productid.toString(),
        'user_id': userId.toString(),
      });
    }
    print('_____sssdsdsfsdfsdfsd_____${request.fields}_________');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);
      if (finalResult['status'] == true) {
        Fluttertoast.showToast(msg: finalResult['message']);
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(msg: finalResult['message']);
      }
    } else {
      print(response.reasonPhrase);
    }
  }
  List<City> cityList = [];
  String cityName = '';
  CitySearchModel?citySearchModel;

 Future <List<String>> searchCityApi({String? filter}) async {
   var request = http.Request('GET', Uri.parse('https://suggest.imimg.com/suggest/suggest.php?q=$filter&tag=suggestions&limit=40&type=city&fields=state%2Cid%2Cstateid%2Cflname%2Calias&display_fields=value%2C%3Dstate&display_separator=%2C%20&match=fuzzy&catid=0&mcatid=0&v=398'));
   request.body = '''''';
   // print('__________${}_________');
   http.StreamedResponse response = await request.send();
   List<String> list =  [];
   if (response.statusCode == 200) {

     var result = await response.stream.bytesToString();
     var finalResult = CitySearchModel.fromJson(json.decode(result));
     setState(() {
       cityList = finalResult.city!;
       cityList.insert(0, City(value: 'Select All City'));
       cityList.forEach((element) {
         list.add(element.value ?? '') ;
       });

     });
     return list ;
   }
   else {
   print(response.reasonPhrase);
   return list ;
   }

 }

  // getEventTypes() async {
  //   var uri = Uri.parse(getEventsApis.toString());
  //   // '${Apipath.getCitiesUrl}');
  //   var request = http.MultipartRequest("GET", uri);
  //   Map<String, String> headers = {
  //     "Accept": "application/json",
  //   };
  //
  //   request.headers.addAll(headers);
  //   // request.fields['type_id'] = "1";
  //   // request.fields['vendor_id'] = userID;
  //   var response = await request.send();
  //   print(response.statusCode);
  //   String responseData = await response.stream.transform(utf8.decoder).join();
  //   var userData = json.decode(responseData);
  //
  //   setState(() {
  //     eventList = EventTypeModel.fromJson(userData).categories!;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    //WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Confirm Exit"),
                  content: const Text("Are you sure you want to exit?"),
                  actions: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: colors.primary),
                      child: const Text("YES"),
                      onPressed: () {
                        SystemNavigator.pop();
                      },
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: colors.primary),
                      child: const Text("NO"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              });
          return true;
        },
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: colors.primary,
            onPressed: () {
              showDialogBox();
            },
            child:Image.asset(
              "Images/flot.png",
              scale: 2,
            )

          ),
          key: _scaffoldState,
          drawer: Drawer(child: getDrawer(context),),
          body:
          GetSub == null || GetSub == ''
              ? const Center(child: CircularProgressIndicator())
              : isSwitched == true
              ? specific(context)
              :
              RefreshIndicator(
              onRefresh:() {
              return Future.delayed(const Duration(seconds: 2), () {
                homeCategories();
                homeProducts();
                getProfile();
                getSpecifiyApi();
              });
            },
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return  SingleChildScrollView(
                  child: Column(children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: colors.primary,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              GestureDetector(
                                child: InkWell(
                                  onTap: () {
                                    _scaffoldState.currentState
                                        ?.openDrawer();
                                  },
                                  child: Image.asset(
                                    "Images/drawer.png",
                                    height: 20,
                                    width: 20,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.only(top: 5, left: 10),
                                child: userId == 'null' ||
                                    userId == null ||
                                    userId == ''
                                    ? const Text(
                                  " ",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white),
                                )
                                    : Text(
                                  "Hii ${namee ?? ''}",
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.white),
                                ),
                              ),
                              const Spacer(),
                              userId == 'null' ||
                                  userId == null ||
                                  userId == ''
                                  ? const SizedBox(
                                height: 40,
                              )
                                  : Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      textValue,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.white),
                                    ),
                                    Transform.scale(
                                      scale: 1 * 0.8,
                                      child: Switch(
                                        onChanged: toggleSwitch,
                                        value: isSwitched,
                                        activeColor: colors.primary,
                                        activeTrackColor:
                                        colors.white,
                                        inactiveThumbColor:
                                        colors.white,
                                        inactiveTrackColor:
                                        Colors.grey,
                                      ),
                                    ),
                                  ]),
                            ],
                          ),
                          Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                              width: MediaQuery.of(context).size.width / 2.2,
                             height: 48,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(
                                bottom: 10, left: 19),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: colors.white,
                                ),
                                child:DropdownSearch<String>(
                                  asyncItems: (filter) => searchCityApi(filter: filter),
                                  compareFn: (i, s) => i == s,

                                  dropdownDecoratorProps: const DropDownDecoratorProps(
                                      textAlign: TextAlign.center,
                                      dropdownSearchDecoration: InputDecoration(border: InputBorder.none,hintText: 'All India',hintStyle: TextStyle(color: Colors.black))),

                                  onChanged: (value){
                                    // selectedCity = value ;
                                    cityController = value  ;
                                  },
                                  selectedItem: cityController,


                                  popupProps: PopupPropsMultiSelection.modalBottomSheet(
                                    isFilterOnline: true,

                                    showSelectedItems: true,
                                    showSearchBox: true,
                                    itemBuilder: _customPopupItemBuilderExample2,
                                    favoriteItemProps: const FavoriteItemProps(
                                      showFavoriteItems: true,
                                      /*favoriteItems: (us) {
                                    return us.where((e) => e.value!.contains("Mrs")).toList();
                                  },*/
                                    ),
                                  ),
                                ),
                                /*CustomSearchableDropDown(
                                  // dropdownHintText: "Country",
                                  suffixIcon: const Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    color: colors.black,

                                  ),

                                  backgroundColor: colors.white.withOpacity(0.0005),
                                  dropdownBackgroundColor:
                                  colors.white.withOpacity(0.0005),

                                 // dropdownItemStyle: editProfileStyle(14),
                                  // dropdownHintText: TextStyle(
                                  //   color: AppColors.whit
                                  // ),
                                  items: cityList,
                                  // initialValue:  controller.countryList,
                                  label: 'All India',
                                 // labelStyle: editProfileStyle(14),

                                  multiSelectTag: 'City',
                                  decoration: BoxDecoration(
                                      color: colors.white.withOpacity(0.0005),
                                      // border: Border.all(color: Colors.white),
                                      borderRadius:
                                      BorderRadius.circular(15)
                                    // color: Colors.white
                                    // border: Border.all(
                                    //   color: CustomColors.lightgray.withOpacity(0.5),
                                    // )
                                  ),
                                  multiSelect: false,

                                  dropDownMenuItems: cityList.map((item) {
                                    return "${item.value}";
                                  }).toList() ,
                                  onChanged: (value) {
                                    if (value != null) {
                                      setState(() {
                                       cityController = value.value;

                                       cityName  = value.value;
                                       searchCityApi();
                                      });
                                    }
                                  },


                                ),*/
                              ),

                              Container(
                                width:
                                MediaQuery.of(context).size.width / 2.5,
                                height: 50,
                                alignment: Alignment.center,
                                margin: const EdgeInsets.only(
                                  bottom: 10,
                                ),
                                child: TextField(
                                  readOnly: true,
                                  onTap: (){

                                    Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            SearchScreen(
                                                              selectedCity: cityController,
                                                            )));

                                            },
                                  controller: searchC,
                                  decoration: InputDecoration(
                                    contentPadding:
                                    const EdgeInsets.only(top: 20),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 1,
                                          color: Colors.transparent),
                                      borderRadius:
                                      BorderRadius.circular(7),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.white),
                                      borderRadius:
                                      BorderRadius.circular(7),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.white),
                                      borderRadius:
                                      BorderRadius.circular(7),
                                    ),
                                    hintText: "Search",
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintStyle: const TextStyle(
                                        color: Colors.black54),
                                    prefixIcon: const Icon(
                                      Icons.search,
                                      size: 20,
                                    ),
                                    prefixIconColor: Colors.black,
                                    suffixIcon: IconButton(icon: const Icon(Icons.mic),
                                      onPressed: (){
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SearchScreen(
                                                      selectedCity: cityController,
                                                    )));
                                      },),
                                    suffixIconColor: Colors.black,
                                  ),
                                  onChanged: (value) {

                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 13,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        finalImages?.data == null || finalImages?.data == ""
                            ? const Center(
                          child: CircularProgressIndicator(
                            color: colors.primary,
                          ),
                        )
                            : Container(
                          margin: const EdgeInsets.only(
                              top: 10, left: 8, right: 8, bottom: 10),
                          child: CarouselSlider(
                            items: finalImages?.data
                                .map(
                                  (item) => Padding(
                                padding:
                                const EdgeInsets.all(5.0),
                                child: ClipRRect(
                                  borderRadius:
                                  BorderRadius.circular(10),
                                  child: Image.network(
                                    item.image,
                                    fit: BoxFit.fill,
                                    width: double.infinity,
                                  ),
                                ),
                              ),
                            )
                                .toList(),
                            carouselController: carouselController,
                            options: CarouselOptions(
                              scrollPhysics:
                              const BouncingScrollPhysics(),
                              autoPlay: true,
                              autoPlayInterval:
                              const Duration(seconds: 5),
                              autoPlayAnimationDuration:
                              const Duration(milliseconds: 500),
                              aspectRatio: 2,
                              viewportFraction: 1,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  currentIndex = index;
                                });
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 7),
                          child: AnimatedSmoothIndicator(
                            activeIndex: currentIndex,
                            count: finalImages?.data.length ?? 0,
                            effect: const SlideEffect(
                              spacing: 5.6,
                              radius: 10.0,
                              dotWidth: 7.0,
                              dotHeight: 7.0,
                              dotColor: Color.fromRGBO(246, 137, 133, 0.5),
                              activeDotColor: colors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10,),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 6.7,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              /*InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SupplierScreen("type"
                                          )));
                                },
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "Images/Buyer.png",
                                      height:
                                      MediaQuery.of(context).size.height / 8,
                                      width:
                                      MediaQuery.of(context).size.width / 5.7,
                                    ),
                                    const Text(
                                      "Supplier",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const ClientScreen()));
                                },
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "Images/img1.png",
                                      height:
                                      MediaQuery.of(context).size.height / 8,
                                      width:
                                      MediaQuery.of(context).size.width / 5.7,
                                    ),
                                    const Text(
                                      "Client",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const AllCommunity()));
                                },
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "Images/community.png",
                                      height:
                                      MediaQuery.of(context).size.height / 8,
                                      width:
                                      MediaQuery.of(context).size.width / 5.7,
                                    ),
                                    const Text(
                                      "Community",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),*/
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const OurActivity()));
                                },
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "Images/activity.png",
                                      height:
                                      MediaQuery.of(context).size.height / 8,
                                      width:
                                      MediaQuery.of(context).size.width / 5.7,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(
                                        right: 3,
                                      ),
                                      child: Text(
                                        "Our Activity",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const YourSuggestion()));
                                },
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "Images/suggetion.png",
                                      height:
                                      MediaQuery.of(context).size.height / 8,
                                      width:
                                      MediaQuery.of(context).size.width / 5.7,
                                    ),
                                    const Text(
                                      "Your Suggestion",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(left: 15),
                      child:  Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "Category",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: colors.black),
                            ),

                          ],
                        ),
                      )
                    ),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 10),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                controller: _scrollController,
                                shrinkWrap: true,
                                itemCount: homeCategory?.data?.length ?? 0,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AllProduct(
                                                    catId: homeCategory!
                                                        .data![index].id)),
                                      );
                                    },
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(7)),
                                      elevation: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                            height: 45,
                                            child: Center(
                                                child: Text(
                                                  "${homeCategory?.data?[index].name}",
                                                  style: const TextStyle(
                                                      color: colors.black,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ))),
                                      ),
                                    ),
                                  );
                                  //  categoryCard(context,homeCategory?.data?[index].image ?? '', homeCategory?.data?[index].name ?? '' );
                                }),
                          ),

                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),
                    carosalSlider(),
                    const SizedBox(
                      height: 5,
                    ),
                    getSubcat(),
                    const SizedBox(
                      height: 8,
                      //  width: 30,
                    ),

                  ]),
                );
              },

            ),
          ),
        ),
      ),
    );
  }


  Widget carosalSlider(){
   return Container(
      height: 200,
      width: MediaQuery.of(context).size.width / 1.0,
      margin:
      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: CarouselSlider(
        items: adImages?.data
            .map(
              (item) => Padding(
            padding: const EdgeInsets.all(3.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                '${ApiService.adbaseUrl + item.name}',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
        )
            .toList(),
        carouselController: carouselController,
        options: CarouselOptions(
          scrollPhysics: const BouncingScrollPhysics(),
          autoPlay: true,
          aspectRatio: 1,
          viewportFraction: 1,
          onPageChanged: (index, reason) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
    );
  }
  late GoogleMapController mapController;
  final Set<Marker> markers = {
    const Marker(
      markerId: MarkerId('1'),
      position: LatLng(37.7749, -122.4194), // Replace with the coordinates of your placeMark
      infoWindow: InfoWindow(title: 'Marker Title'),
    ),
    // Add more markers as needed
  };
  GetCatByProductModel? GetSub;
  List<dataListHome> productList = [];
  getCatByProductApi() async {
    print('=================sab cat1');
    var headers = {
      'Cookie': 'ci_session=be80181e164bc517227ef11678499fc7c49890a1'
    };
    var request = http.MultipartRequest(
          'POST', Uri.parse('${baseUrl}get_products_by_category'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = GetCatByProductModel.fromJson(json.decode(result));
      setState(() {
        GetSub = finalResult;
      });
    } else {
      print(response.reasonPhrase);
    }
  }
  getSubcat() {
    return Container(
      padding: const EdgeInsets.only(top: 0, left: 12, right: 5),
      child: ListView.builder(
        itemCount: GetSub!.data!.length,
        // scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, i) {
          if (i == null)
            return Container();
          else {
            return GetSub!.data![i].products == null ||
                GetSub!.data![i].products!.length == 0
                ? const SizedBox.shrink()
                : Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: InkWell(
                onTap: () {

                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AllProduct(
                                          catId: GetSub!.data![i].id
                                              .toString())),
                                );
                              },
                              child: Text(
                                "${GetSub!.data![i].name!.toUpperCase()}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 1.9,
                      //  GetSub!.data![i].products!.length >3? 280:140,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: const ScrollPhysics(),
                          itemCount: GetSub!.data![i].products!.length,
                          //> 6 ? 6 : GetSub!.data![i].products!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetailsHome(pId: GetSub!.data![i].products![0].productId,businessName: GetSub!.data![i].products![0].typeOfSeller,)));
                              },
                              child: Container(
                                width:
                                MediaQuery.of(context).size.width / 1.2,
                                margin: const EdgeInsets.all(0),
                                child: Card(
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        height: MediaQuery.of(context)
                                            .size
                                            .height /
                                            5.6,
                                        width: MediaQuery.of(context)
                                            .size
                                            .width,
                                        child: ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(20),
                                          child: Image.network(
                                            "${GetSub!.data![i].products![0].productImage}" ??
                                                '',
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 24, top: 10),
                                        child: Text(
                                          GetSub!.data![i].products![0].name ??'N/A'
                                              '',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      ),
                                      Container(
                                          margin: const EdgeInsets.only(
                                              left: 24, top: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  const CircleAvatar(
                                                      backgroundColor:
                                                      colors.primary,
                                                      radius: 10,
                                                      child: Icon(
                                                        Icons
                                                            .person_rounded,
                                                        color: colors.white,
                                                        size: 15,
                                                      )),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                      GetSub!.data![i].products![0].storeName ?? 'N/A'),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                      width: 120,
                                                      child: Text(
                                                        GetSub!.data![i].products![0].typeOfSeller== null ? '':"(${GetSub!.data![i].products![0].typeOfSeller})" ??
                                                            '',
                                                        maxLines: 1,
                                                        overflow:
                                                        TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            color: colors
                                                                .black,
                                                            fontWeight:
                                                            FontWeight
                                                                .bold),
                                                      )),
                                                ],
                                              )
                                            ],
                                          )),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 24, top: 5),
                                        child: Row(
                                          children: [
                                            const CircleAvatar(
                                              radius: 10,
                                              backgroundColor:
                                              colors.primary,
                                              child: Icon(
                                                Icons.location_pin,
                                                size: 15,
                                                color: colors.white,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                                width: 180,
                                                child: Text(
                                                  GetSub!.data![i].products![0].address ??
                                                      'N/A',
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                )),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 20, top: 5, right: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            InkWell(
                                                onTap: () {
                                                  launch(
                                                      "${GetSub!.data![i].products![0].video}");
                                                },
                                                child: Row(
                                                  children: const [
                                                    Icon(
                                                      Icons
                                                          .video_camera_back_outlined,
                                                      color: colors.primary,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    InkWell(
                                                        child: Text(
                                                            "Watch Video"))
                                                  ],
                                                )),
                                            Row(
                                              children: [
                                                const CircleAvatar(
                                                    radius: 15,
                                                    backgroundColor:
                                                    Colors.white,
                                                    child: Icon(
                                                      Icons.image,
                                                      color: colors.primary,
                                                    )),
                                                InkWell(
                                                    onTap: () {
                                                      showDialog<String>(
                                                        context: context,
                                                        builder: (BuildContext
                                                        context) =>
                                                            AlertDialog(
                                                              title: const Text(
                                                                  'Broucher Image'),
                                                              content:GetSub!.data![i].products![0].broucherImage == null ? Image.asset("Images/no-image-icon.png",height: 120,width:double.infinity,fit: BoxFit.fill,):
                                                              Image.network(
                                                                  "${GetSub!.data![i].products![0].broucherImage}"),
                                                            ),
                                                      );
                                                    },
                                                    child: const Text("Broucher"))
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 20, right: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          children: [
                                          userId==null ? InkWell(
                                            onTap: (){
                                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage(),));
                                            },
                                            child: Container(
                                                height: 25,
                                                width: 25,
                                                decoration:
                                                const BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius
                                                            .circular(
                                                            50)),
                                                    color: Colors
                                                        .deepPurple),
                                                child: const Icon(
                                                  Icons.add_circle,
                                                  size: 15,
                                                  color: Colors.white,
                                                ),
                                              ),
                                          ) : SizedBox.shrink(),
                                            Container(
                                              height: 25,
                                              width: 25,
                                              decoration:
                                              const BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.all(
                                                      Radius
                                                          .circular(
                                                          5)),
                                                  color: Colors
                                                      .deepPurple),
                                              child: const Padding(
                                                padding: EdgeInsets.only(
                                                    left: 5,
                                                    right: 5,
                                                    top: 3,
                                                    bottom: 3),
                                                child: Icon(
                                                  Icons.message,
                                                  size: 15,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 25,
                                              width: 25,
                                              decoration:
                                              const BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.all(
                                                      Radius
                                                          .circular(
                                                          6)),
                                                  color:
                                                  colors.secondary),
                                              child: const Padding(
                                                padding: EdgeInsets.only(
                                                    left: 5,
                                                    right: 5,
                                                    top: 3,
                                                    bottom: 3),
                                                child: Icon(
                                                  Icons.mail_outline,
                                                  size: 15,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 25,
                                              width: 25,
                                              decoration:
                                              const BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.all(
                                                      Radius
                                                          .circular(
                                                          50)),
                                                  color:
                                                  colors.primary),
                                              child: const Padding(
                                                padding: EdgeInsets.only(
                                                    left: 5,
                                                    right: 5,
                                                    top: 3,
                                                    bottom: 3),
                                                child: Icon(
                                                  Icons.location_pin,
                                                  size: 15,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                                  20,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                                  3,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  const BorderRadius
                                                      .all(
                                                      Radius.circular(
                                                          6)),
                                                  border: Border.all(
                                                      width: 2,
                                                      color: Colors.grey),
                                                  color: colors.white),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceAround,
                                                children: [
                                                  Container(
                                                    height: 25,
                                                    width: 25,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                        const BorderRadius
                                                            .all(Radius
                                                            .circular(
                                                            50)),
                                                        color: GetSub!
                                                            .data![
                                                        i]
                                                            .products![
                                                        0]
                                                            .taxNumber ==
                                                            ""
                                                            ? Colors.red
                                                            : colors
                                                            .secondary),
                                                    child: const Padding(
                                                      padding:
                                                      EdgeInsets.only(
                                                          left: 5,
                                                          right: 5,
                                                          top: 3,
                                                          bottom: 3),
                                                      child: Icon(
                                                        Icons.description,
                                                        size: 15,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 25,
                                                    width: 25,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                        const BorderRadius
                                                            .all(Radius
                                                            .circular(
                                                            50)),
                                                        color: GetSub!
                                                            .data![
                                                        i]
                                                            .products![
                                                        0]
                                                            .subscriptionType ==
                                                            1
                                                            ? colors.primary
                                                            : colors
                                                            .secondary),
                                                    child: const Padding(
                                                      padding:
                                                      EdgeInsets.only(
                                                          left: 5,
                                                          right: 5,
                                                          top: 3,
                                                          bottom: 3),
                                                      child: Icon(
                                                        Icons
                                                            .check_circle_outline,
                                                        size: 15,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 25,
                                                    width: 25,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                        const BorderRadius
                                                            .all(Radius
                                                            .circular(
                                                            50)),
                                                        color: GetSub!
                                                            .data![
                                                        i]
                                                            .products![
                                                        0]
                                                            .subscriptionType ==
                                                            1
                                                            ? colors.primary
                                                            : colors
                                                            .secondary),
                                                    child: const Padding(
                                                      padding:
                                                      EdgeInsets.only(
                                                          left: 5,
                                                          right: 5,
                                                          top: 3,
                                                          bottom: 3),
                                                      child: Icon(
                                                        Icons.verified_user,
                                                        size: 15,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Center(
                                        child: Btn(
                                          height: 40,
                                          width: 150,
                                          title: "Contact Supplier",
                                          onPress: () {
                                            showDialogContactSuplier(GetSub!.data![i].products![index].productId.toString(), mobilee);
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
  GetCategoryModel? getcategorymodel;
  getCategory() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var headers = {
      'Cookie': 'ci_session=ea5681bb95a83750e0ee17de5e4aa2dca97184ef'
    };
    var request =
    http.MultipartRequest('POST', Uri.parse('${ApiService.getCatSpecific}'));

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse =
      GetCategoryModel.fromJson(json.decode(finalResponse));

      // String? category_id = jsonResponse.data?[0].id ?? "";
      // preferences.setString("category_id", category_id);
      setState(() {
        getcategorymodel = jsonResponse;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  Widget specific(BuildContext context) {
    return homeSpecificModel?.data == null || homeSpecificModel?.data == ''
        ? Container(
      height: MediaQuery.of(context).size.height / 1.2,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    )
        :
        RefreshIndicator(
      onRefresh:() {
        return Future.delayed(const Duration(seconds: 2), () {
          getSpecifiyApi();
        });
      },
      child: ListView.builder(
        itemCount: 1,
          itemBuilder: (context,i){
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: colors.primary,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          child: InkWell(
                            onTap: () {
                              _scaffoldState.currentState?.openDrawer();
                            },
                            child: Image.asset(
                              "Images/drawer.png",
                              height: 20,
                              width: 20,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5, left: 10),
                          child: userId == 'null' ||
                              userId == null ||
                              userId == ''
                              ? const Text(
                            " ",
                            style: TextStyle(
                                fontSize: 15, color: Colors.white),
                          )
                              : Text(
                            "Hii ${namee ?? ''}",
                            style: const TextStyle(
                                fontSize: 15, color: Colors.white),
                          ),
                        ),
                        const Spacer(),
                        userId == 'null' || userId == null || userId == ''
                            ? const SizedBox(
                          height: 40,
                        )
                            : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                textValue,
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.white),
                              ),
                              Transform.scale(
                                scale: 1 * 0.8,
                                child: Switch(
                                  onChanged: toggleSwitch,
                                  value: isSwitched,
                                  activeColor: colors.primary,
                                  activeTrackColor: colors.white,
                                  inactiveThumbColor: colors.primary,
                                  inactiveTrackColor: colors.white,
                                ),
                              ),
                            ]),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: (){

                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2.2,
                            height: 48,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(
                                bottom: 10, left: 19),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: colors.white,
                            ),
                            child: DropdownSearch<String>(
                              asyncItems: (filter) => searchCityApi(filter: filter),
                              compareFn: (i, s) => i == s,

                              dropdownDecoratorProps: const DropDownDecoratorProps(
                                textAlign: TextAlign.center,
                                  dropdownSearchDecoration: InputDecoration(border: InputBorder.none,hintText: 'All India',hintStyle: TextStyle(color: Colors.black))),

                              onChanged: (value){
                               // selectedCity = value ;
                                cityController = value  ;
                              },
                              selectedItem: cityController,


                              popupProps: PopupPropsMultiSelection.modalBottomSheet(
                                isFilterOnline: true,

                                showSelectedItems: true,
                                showSearchBox: true,
                                itemBuilder: _customPopupItemBuilderExample2,
                                favoriteItemProps: const FavoriteItemProps(
                                  showFavoriteItems: true,
                                  /*favoriteItems: (us) {
                                    return us.where((e) => e.value!.contains("Mrs")).toList();
                                  },*/
                                ),
                              ),
                            ),
                            /*CustomSearchableDropDown(
                              // dropdownHintText: "Country",
                              suffixIcon: const Icon(
                                Icons.keyboard_arrow_down_sharp,
                                color: colors.black,
                              ),
                              backgroundColor: colors.white.withOpacity(0.0005),
                              dropdownBackgroundColor:
                              colors.white.withOpacity(0.0005),
                              // dropdownItemStyle: editProfileStyle(14),
                              // dropdownHintText: TextStyle(
                              //   color: AppColors.whit
                              // ),
                              items: cityList,
                              // initialValue:  controller.countryList,
                              label: 'All India',
                              // labelStyle: editProfileStyle(14),

                              multiSelectTag: 'City',
                              decoration: BoxDecoration(
                                  color: colors.white.withOpacity(0.0005),
                                  // border: Border.all(color: Colors.white),
                                  borderRadius:
                                  BorderRadius.circular(15)
                                // color: Colors.white
                                // border: Border.all(
                                //   color: CustomColors.lightgray.withOpacity(0.5),
                                // )
                              ),

                              multiSelect: false,

                              dropDownMenuItems: cityList.map((item) {
                                return "${item.value}";
                              }).toList() ,
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    cityController = value.value;


                                  });
                                }
                              },

                            ),*/
                          ),
                        ),

                        Container(
                          width:
                          MediaQuery.of(context).size.width / 2.5,
                          height: 50,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(
                            bottom: 10,
                          ),
                          child: TextField(
                            readOnly: true,
                            onTap: (){

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SearchScreen(
                                            selectedCity: cityController,
                                          )));

                            },
                            controller: searchC,
                            decoration: InputDecoration(
                              contentPadding:
                              const EdgeInsets.only(top: 20),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1,
                                    color: Colors.transparent),
                                borderRadius:
                                BorderRadius.circular(7),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: Colors.white),
                                borderRadius:
                                BorderRadius.circular(7),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: Colors.white),
                                borderRadius:
                                BorderRadius.circular(7),
                              ),
                              hintText: "Search",
                              filled: true,
                              fillColor: Colors.white,
                              hintStyle: const TextStyle(
                                  color: Colors.black54),
                              prefixIcon: const Icon(
                                Icons.search,
                                size: 20,
                              ),
                              prefixIconColor: Colors.black,
                              suffixIcon: IconButton(icon: const Icon(Icons.mic),
                                onPressed: (){

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SearchScreen(
                                                selectedCity: cityController,
                                              )));
                                  // initSpeechState();
                                  // if (!_hasSpeech) {
                                  //   initSpeechState();
                                  // } else {
                                  //   !_hasSpeech || speech.isListening
                                  //       ? null
                                  //       : startListening();
                                  // }
                                },),
                              suffixIconColor: Colors.black,
                            ),
                            onChanged: (value) {

                            },
                          ),
                        ),
                        const SizedBox(
                          width: 13,
                        ),
                      ],
                    ),

                  ],
                ),
              ),
              Column(
                children: [
                  finalImages?.data == null || finalImages?.data == ""
                      ? const Center(
                    child: CircularProgressIndicator(
                      color: colors.primary,
                    ),
                  )
                      : Container(
                    margin: const EdgeInsets.only(
                        top: 20, left: 15, right: 15, bottom: 10),
                    child: CarouselSlider(
                      items: finalImages?.data
                          .map(
                            (item) => ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            item.image,
                            fit: BoxFit.fill,
                            width: double.infinity,
                          ),
                        ),
                      )
                          .toList(),
                      carouselController: carouselController,
                      options: CarouselOptions(
                        scrollPhysics: const BouncingScrollPhysics(),
                        autoPlay: true,
                        aspectRatio: 2,
                        viewportFraction: 1,
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 7),
                    child: AnimatedSmoothIndicator(
                      activeIndex: currentIndex,
                      count: finalImages?.data.length ?? 0,
                      effect: const SlideEffect(
                        spacing: 5.6,
                        radius: 10.0,
                        dotWidth: 7.0,
                        dotHeight: 7.0,
                        dotColor: Color.fromRGBO(246, 137, 133, 0.5),
                        activeDotColor: colors.primary,
                      ),
                    ),
                  ),
                ],
              ),

              Container(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 6.7,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SupplierScreen(
                                    )));
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                "Images/Buyer.png",
                                height:
                                MediaQuery.of(context).size.height / 8,
                                width:
                                MediaQuery.of(context).size.width / 5.7,
                              ),
                              const Text(
                                "Supplier",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ClientScreen()));
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                "Images/img1.png",
                                height:
                                MediaQuery.of(context).size.height / 8,
                                width:
                                MediaQuery.of(context).size.width / 5.7,
                              ),
                              const Text(
                                "Client",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AllCommunity()));
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                "Images/community.png",
                                height:
                                MediaQuery.of(context).size.height / 8,
                                width:
                                MediaQuery.of(context).size.width / 5.7,
                              ),
                              const Text(
                                "Community",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const OurActivity()));
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                "Images/activity.png",
                                height:
                                MediaQuery.of(context).size.height / 8,
                                width:
                                MediaQuery.of(context).size.width / 5.7,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                  right: 3,
                                ),
                                child: Text(
                                  "Our Activity",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const YourSuggestion()));
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                "Images/suggetion.png",
                                height:
                                MediaQuery.of(context).size.height / 8,
                                width:
                                MediaQuery.of(context).size.width / 5.7,
                              ),
                              const Text(
                                "Your Suggestion",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "All Categories",
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                    InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => GoogleMapHome(model: GetSub?.data)));
                        },
                        child: Container(

                            height: 30,
                            width: 30,
                            decoration:  BoxDecoration(
                                color: colors.primary,
                                borderRadius: BorderRadius.circular(50)
                            ),
                            child: const Center(child: Icon(Icons.location_on_outlined,color: colors.white,))
                        )
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),

              SizedBox(
                height: 80,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AllProduct(
                                  catIdSpeci:
                                  getcategorymodel?.data?[index].id,
                                  isTrue: true,
                                )),
                          );
                        },
                        child: Card(
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2.4,
                            height: 80,
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                "${getcategorymodel?.data?[index].name ?? ''}",
                                maxLines: 3,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              carosalSlider(),
              const SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 15),
                child: const Text(
                  "Business Supplier Category",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
              ),
              getSpecifyHomeBusiness(),
              const SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 15),
                child: const Text(
                  "Business Client Category",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
              ),

              homeSpecificModel!.data!.clientData == null || homeSpecificModel!.data!.clientData =="" ?const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Business Client Category !!"),
              ): getSpecifyHomeCleint(),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        );
      })
    );
  }

  Widget _customPopupItemBuilderExample2(BuildContext context, String item, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: ListTile(
        selected: isSelected,
        title: Text(item),
        //subtitle: Text(item.createdAt.toString()),
        /*leading: CircleAvatar(
          backgroundImage: NetworkImage(item.avatar),
        ),*/
      ),
    );
  }

  getSpecifyHomeBusiness() {
    print('${homeSpecificModel!.data!.businsessData?.length}____________');
    return Container(
      padding: const EdgeInsets.only(top: 0, left: 9, right: 5),
      child: SizedBox(
        height: 400,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: const ScrollPhysics(),
            itemCount: homeSpecificModel?.data?.businsessData?.length ?? 0,
            //> 6 ? 6 : GetSub!.data![i].products!.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () async {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetailsHome(pId: homeSpecificModel!.data!.businsessData![index].id,)));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  margin: const EdgeInsets.all(0),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          height: MediaQuery.of(context).size.height / 5.6,
                          width: MediaQuery.of(context).size.width,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              "${homeSpecificModel!.data!.businsessData![index].image}" ??
                                  '',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 24, top: 10),
                          child: Text(
                            "${homeSpecificModel!.data!.businsessData![index].name}" ??
                                '',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.only(left: 24, top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const CircleAvatar(
                                        backgroundColor: colors.primary,
                                        radius: 10,
                                        child: Icon(
                                          Icons.person_rounded,
                                          color: colors.white,
                                          size: 15,
                                        )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                        "${homeSpecificModel!.data!.businsessData![index].storeName}" ??
                                            ''),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                        width: 90,
                                        child: Text(
                                          "(${homeSpecificModel!.data!.businsessData![index].typeOfSeller})" ??
                                              '',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: colors.black,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ],
                                )
                              ],
                            )),
                        Container(
                          margin: const EdgeInsets.only(left: 24, top: 5),
                          child: Row(
                            children: [
                              const CircleAvatar(
                                radius: 10,
                                backgroundColor: colors.primary,
                                child: Icon(
                                  Icons.location_pin,
                                  size: 15,
                                  color: colors.white,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                  width: 180,
                                  child: Text(
                                    "${homeSpecificModel!.data!.businsessData![index].sellerAddress}" ??
                                        "",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 20, top: 5, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                  onTap: () {
                                    launch(
                                        "${homeSpecificModel!.data!.businsessData![index].video}");
                                  },
                                  child: Row(
                                    children: const [
                                      Icon(
                                        Icons.video_camera_back_outlined,
                                        color: colors.primary,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      InkWell(child: Text("Watch Video"))
                                    ],
                                  )),
                              Row(
                                children: [
                                  const CircleAvatar(
                                      radius: 15,
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        Icons.image,
                                        color: colors.primary,
                                      )),
                                  InkWell(
                                      onTap: () {
                                        showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                                title: const Text('Broucher Image'),
                                                content: homeSpecificModel!.data!.businsessData![index].broucherImage == null  || homeSpecificModel!.data!.businsessData![index].broucherImage
                                                   == "" ? Image.asset("Images/no-image-icon.png",height: 120,width:double.infinity,fit: BoxFit.fill,) :Image.network(
                                                    "${homeSpecificModel!.data!.businsessData![index].broucherImage}"),
                                              ),
                                        );
                                      },
                                      child: const Text("Broucher"))
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: 25,
                                width: 25,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                    color: Colors.deepPurple),
                                child: const Icon(
                                  Icons.add_circle,
                                  size: 15,
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                height: 25,
                                width: 25,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                    color: Colors.deepPurple),
                                child: const Padding(
                                  padding: EdgeInsets.only(
                                      left: 5, right: 5, top: 3, bottom: 3),
                                  child: Icon(
                                    Icons.message,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Container(
                                height: 25,
                                width: 25,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                                    color: colors.secondary),
                                child: const Padding(
                                  padding: EdgeInsets.only(
                                      left: 5, right: 5, top: 3, bottom: 3),
                                  child: Icon(
                                    Icons.mail_outline,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Container(
                                height: 25,
                                width: 25,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                    color: colors.primary),
                                child: const Padding(
                                  padding: EdgeInsets.only(
                                      left: 5, right: 5, top: 3, bottom: 3),
                                  child: Icon(
                                    Icons.location_pin,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height / 20,
                                width: MediaQuery.of(context).size.width / 3,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(6)),
                                    border: Border.all(
                                        width: 2, color: Colors.grey),
                                    color: colors.white),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      height: 25,
                                      width: 25,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(50)),
                                          color: homeSpecificModel!
                                              .data!
                                              .businsessData![index]
                                              .taxNumber ==
                                              ""
                                              ? colors.primary
                                              : colors.secondary),
                                      child: const Padding(
                                        padding: EdgeInsets.only(
                                            left: 5,
                                            right: 5,
                                            top: 3,
                                            bottom: 3),
                                        child: Icon(
                                          Icons.description,
                                          size: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 25,
                                      width: 25,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(50)),
                                          color: homeSpecificModel!
                                              .data!
                                              .businsessData![index]
                                              .subscriptionType ==
                                              1
                                              ? colors.primary
                                              : colors.secondary),
                                      child: const Padding(
                                        padding: EdgeInsets.only(
                                            left: 5,
                                            right: 5,
                                            top: 3,
                                            bottom: 3),
                                        child: Icon(
                                          Icons.check_circle_outline,
                                          size: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 25,
                                      width: 25,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(50)),
                                          color: homeSpecificModel!
                                              .data!
                                              .businsessData![index]
                                              .subscriptionType ==
                                              1
                                              ? colors.primary
                                              : colors.secondary),
                                      child: const Padding(
                                        padding: EdgeInsets.only(
                                            left: 5,
                                            right: 5,
                                            top: 3,
                                            bottom: 3),
                                        child: Icon(
                                          Icons.verified_user,
                                          size: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Btn(
                            height: 40,
                            width: 150,
                            onPress: () {
                              showDialogContactSuplier(
                                  homeSpecificModel!
                                      .data!.businsessData![index].id
                                      .toString(),
                                  mobilee);
                            },
                            title: "Contact Supplier",
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  getSpecifyHomeCleint() {
    return Container(
      padding: const EdgeInsets.only(top: 0, left: 0, right: 30),
      child: Container(
        height: 400,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: const ScrollPhysics(),
            itemCount: homeSpecificModel?.data?.clientData?.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () async {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetailsHome(pId: homeSpecificModel!.data!.clientData![index].id,)));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  margin: const EdgeInsets.all(0),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          height: MediaQuery.of(context).size.height / 5.6,
                          width: MediaQuery.of(context).size.width,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              "${homeSpecificModel?.data?.clientData?[index].image}" ??
                                  '',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 24, top: 10),
                          child: Text(
                            "${homeSpecificModel!.data!.clientData![index].name}" ??
                                '',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.only(left: 24, top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const CircleAvatar(
                                        backgroundColor: colors.primary,
                                        radius: 10,
                                        child: Icon(
                                          Icons.person_rounded,
                                          color: colors.white,
                                          size: 15,
                                        )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                        "${homeSpecificModel!.data!.clientData![index].storeName}" ??
                                            ''),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                        width: 120,
                                        child: Text(
                                          "(${homeSpecificModel!.data!.clientData![index].typeOfSeller})" ??
                                              '',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: colors.black,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ],
                                )
                              ],
                            )),
                        Container(
                          margin: const EdgeInsets.only(left: 24, top: 5),
                          child: Row(
                            children: [
                              const CircleAvatar(
                                radius: 10,
                                backgroundColor: colors.primary,
                                child: Icon(
                                  Icons.location_pin,
                                  size: 15,
                                  color: colors.white,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                  width: 180,
                                  child: Text(
                                    "${homeSpecificModel!.data!.clientData![index].sellerAddress}" ??
                                        "",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 20, top: 5, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                  onTap: () {
                                    launch(
                                        "${homeSpecificModel!.data!.clientData![index].video}");
                                  },
                                  child: Row(
                                    children: const [
                                      Icon(
                                        Icons.video_camera_back_outlined,
                                        color: colors.primary,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      InkWell(child: Text("Watch Video"))
                                    ],
                                  )),
                              Row(
                                children: [
                                  const CircleAvatar(
                                      radius: 15,
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        Icons.image,
                                        color: colors.primary,
                                      )),
                                  InkWell(
                                      onTap: () {
                                        showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                                title: const Text('Broucher Image'),
                                                content: Image.network(
                                                    "${homeSpecificModel!.data!.clientData![index].broucherImage}"),
                                              ),
                                        );
                                      },
                                      child: const Text("Broucher"))
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: 25,
                                width: 25,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                    color: Colors.deepPurple),
                                child: const Icon(
                                  Icons.add_circle,
                                  size: 15,
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                height: 25,
                                width: 25,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                    color: Colors.deepPurple),
                                child: const Padding(
                                  padding: EdgeInsets.only(
                                      left: 5, right: 5, top: 3, bottom: 3),
                                  child: Icon(
                                    Icons.message,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Container(
                                height: 25,
                                width: 25,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                                    color: colors.secondary),
                                child: const Padding(
                                  padding: EdgeInsets.only(
                                      left: 5, right: 5, top: 3, bottom: 3),
                                  child: Icon(
                                    Icons.mail_outline,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Container(
                                height: 25,
                                width: 25,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                    color: colors.primary),
                                child: const Padding(
                                  padding: EdgeInsets.only(
                                      left: 5, right: 5, top: 3, bottom: 3),
                                  child: Icon(
                                    Icons.location_pin,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height / 20,
                                width: MediaQuery.of(context).size.width / 3,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(6)),
                                    border: Border.all(
                                        width: 2, color: Colors.grey),
                                    color: colors.white),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      height: 25,
                                      width: 25,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(50)),
                                          color: homeSpecificModel!
                                              .data!
                                              .clientData![index]
                                              .taxNumber ==
                                              ""
                                              ? colors.primary
                                              : colors.secondary),
                                      child: const Padding(
                                        padding: EdgeInsets.only(
                                            left: 5,
                                            right: 5,
                                            top: 3,
                                            bottom: 3),
                                        child: Icon(
                                          Icons.description,
                                          size: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 25,
                                      width: 25,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(50)),
                                          color: homeSpecificModel!
                                              .data!
                                              .clientData![index]
                                              .subscriptionType ==
                                              1
                                              ? colors.primary
                                              : colors.secondary),
                                      child: const Padding(
                                        padding: EdgeInsets.only(
                                            left: 5,
                                            right: 5,
                                            top: 3,
                                            bottom: 3),
                                        child: Icon(
                                          Icons.check_circle_outline,
                                          size: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 25,
                                      width: 25,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(50)),
                                          color: homeSpecificModel!
                                              .data!
                                              .clientData![index]
                                              .subscriptionType ==
                                              1
                                              ? colors.primary
                                              : colors.secondary),
                                      child: const Padding(
                                        padding: EdgeInsets.only(
                                            left: 5,
                                            right: 5,
                                            top: 3,
                                            bottom: 3),
                                        child: Icon(
                                          Icons.verified_user,
                                          size: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Btn(
                            height: 40,
                            width: 150,
                            title: "Contact Supplier",
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
  ScrollController _scrollController = ScrollController();
  getDrawer(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width / 1.3,
      child: ListView(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            height: 120,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [colors.primary, colors.primary],
              ),
            ),
            child: userId == 'null'
                ? Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Hello Guest ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "  Please Login ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            )
                : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              // main
              children: [
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    namee != null
                        ? Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyProfile()))
                        : const SizedBox();
                  },
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Name: ${namee ?? ''}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Icon(
                              Icons.edit,
                              color: colors.white,
                              size: 15,
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 150,
                          child: Text(
                            "Mobile No: ${mNo ?? ''}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 13),
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  colors.white,
                  colors.primary,
                ],
              ),
            ),

          ),
          ListTile(
            leading: Image.asset(
              "Images/home.png",
              height: 30,
              width: 25,
              color: Colors.grey,
            ),
            title: const Text(
              'Home',
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const B2BHome()),
              );
            },
          ),
          userId == 'null'
              ? const SizedBox()
              : ListTile(
            leading: Image.asset(
              "Images/add product.png",
              height: 30,
              width: 25,
              color: Colors.grey,
            ),
            title: const Text(
              'Add Seller Product',
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddProduct()),
              );
            },
          ),

          userId == 'null'
              ? const SizedBox()
              : ListTile(
            leading: Image.asset(
              "Images/product list.png",
              height: 30,
              width: 30,
              color: Colors.grey,
            ),
            title: const Text(
              'Sell Product List',
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const GetProductScreen()),
              );
            },
          ),
          userId == 'null'
              ? const SizedBox()
              : ListTile(
            leading: Image.asset(
              "Images/purchase product list.png",
              height: 30,
              width: 30,
              color: Colors.grey,
            ),
            title: const Text(
              'Purchase Product List',
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const UpdateProductScreen()),
              );
            },
          ),



          userId == 'null'
              ? const SizedBox() :
          ListTile(
            leading: Image.asset(
              "Images/plans.png", height: 25, width: 20, color: Colors.grey,),
            title: const Text(
              'Plans',
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PlanScreen()),

              );
            },
          ),
          userId == 'null'
              ? const SizedBox() :
          ListTile(
            leading: Image.asset(
              "Images/plans.png", height: 25, width: 20, color: Colors.grey,),
            title: const Text(
              'My Plan',
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyPlanList()),

              );
            },
          ),
          userId == 'null'
              ? const SizedBox():
          ListTile(
            leading: Image.asset(
              "Images/enquery.png", height: 25, width: 20, color: Colors.grey,),
            title: const Text(
              'Enquiry List',
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EnquiryList()),

              );
            },
          ),
          userId == 'null'
              ? const SizedBox()
              : ListTile(
            leading: Image.asset(
              "Images/community.png",
              height: 30,
              width: 23,
              color: Colors.grey,
            ),
            title: const Text(
              'Community',
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CommunityScreen(),
                ),
              );
            },
          ),

          ListTile(
            leading: Image.asset(
              "Images/about us.png",
              height: 30,
              width: 25,
              color: Colors.grey,
            ),
            title: const Text(
              'About Us',
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutUs()),
              );
            },
          ),
          ListTile(
            leading: Image.asset(
              "Images/contact us.png",
              height: 30,
              width: 30,
              color: Colors.grey,
            ),
            title: const Text(
              'Contact Us',
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ContactUs()),
              );
            },
          ),

          ListTile(
            leading: Image.asset(
              "Images/privacy policy.png",
              height: 30,
              width: 26,
              color: Colors.grey,
            ),
            title: const Text(
              'Privacy Policy',
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PrivacyPolicy()),
              );
            },
          ),
          ListTile(
            leading: Image.asset(
              "Images/terms & condition.png",
              height: 30,
              width: 26,
              color: Colors.grey,
            ),
            title: const Text(
              'Terms & Conditions',
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TermCondition()),
              );
            },
          ),
          ListTile(
            leading: Image.asset(
              "Images/faq.png",
              height: 30,
              width: 25,
              color: Colors.grey,
            ),
            title: const Text(
              'FAQ',
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FAQ()),
              );
            },
          ),
          ListTile(
            leading: Image.asset(
              "Images/share app.png",
              height: 30,
              width: 25,
              color: Colors.grey,
            ),
            title: const Text(
              'Share App',
            ),
            onTap: () {
              share();
            },
          ),

           ListTile(
            leading: Image.asset(
              "Images/help.png",
              height: 30,
              width: 30,
              color: Colors.grey,
            ),
            title: const Text(
              'Help & Support',
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const HelpAndSupport()),
              );
            },
          ),
          userId == 'null'
              ? const SizedBox()
              : ListTile(
            leading: Image.asset(
              "Images/delete.png",
              height: 30,
              width: 25,
              color: Colors.grey,
            ),
            title: const Text(
              'Delete Account',
            ),
            onTap: () {
              deleteAccountDailog();

            },
          ),

          userId == 'null'
              ? ListTile(
            leading: Image.asset(
              "Images/logout.png",
              height: 30,
              width: 25,
              color: Colors.grey,
            ),
            title: const Text(
              'Login',
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ));
            },
          )
              : ListTile(
            leading: const Icon(Icons.logout),
            title: const Text(
              'Sign Out',
            ),
            onTap: () async {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Confirm Sign out"),
                      content: const Text(
                          "Are you sure want to sign out? "),
                      actions: <Widget>[
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: colors.primary),
                          child: const Text("YES"),
                          onPressed: () async {
                            removeSesson();

                            SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                            prefs.clear();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()),
                            );
                          },
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: colors.primary),
                          child: const Text("NO"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  });
            },
          ),
        ],
      ),
    );
  }
  deleteAccountDailog() async {
    await dialogAnimate(context,
        StatefulBuilder(builder: (BuildContext context, StateSetter setStater) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setStater) {
                return AlertDialog(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  content: const Text(
                      "Are you sure you want to delete?",
                      style: TextStyle(color: colors.primary)
                  ),
                  actions: <Widget>[
                    TextButton(
                        child: const Text( "NO",style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        }),
                    TextButton(
                        child:  const Text( "YES",style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {

                          showDialogDelete(mNo.toString());
                        })
                  ],
                );
              });
        }));
  }
  deleteAccount() async {
    var headers = {
      'Cookie': 'ci_session=96944ca78b243ab8f0408ccfec94c5f2d8ca05fc'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}'));
    request.fields.addAll({
      'user_id': userId.toString()
    });
    print('_____ssss_____${request.fields}_________');
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult =  jsonDecode(result);
      Fluttertoast.showToast(msg: "${finalResult['message']}",backgroundColor: colors.secondary);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginPage()));
    }
    else {
      print(response.reasonPhrase);
    }

  }
  dialogAnimate(BuildContext context, Widget dialge) {
    return showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(opacity: a1.value, child: dialge),
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        // pageBuilder: null
        pageBuilder: (context, animation1, animation2) {
          return Container();
        } //as Widget Function(BuildContext, Animation<double>, Animation<double>)
    );
  }
  Future<void> share() async {
    await FlutterShare.share(
        title: 'b2b',
        // text: 'Example share text',
        linkUrl: 'https://developmentalphawizz.com/B2B/',
        chooserTitle: 'b2b');
  }
  removeSesson() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('id');
  }
  String? mNo;
  getProfile() async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    var sessionId = sharedPreferences.getString('id');
    var headers = {
      'Cookie': 'ci_session=60e6733f1ca928a67f86820b734e34f4e5e0dd4e'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.getUserProfile}'));
    request.fields.addAll({'user_id': '${sessionId}'});
    print('____sss______${request.fields}_________');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result2 = await response.stream.bytesToString();
      var profileStore = jsonDecode(result2);
      setState(() {
        profileStore2 = profileStore;
      });
    }
    if (profileStore2['error'] == false) {
      namee = "${profileStore2['data']['username'].toString()}";
      emaill = "${profileStore2['data']['email']}";
      mNo = "${profileStore2['data']['mobile']}";
      // companyName2="${profileStore2['data']['mobile']}";
      bussinessAddress2 = "${profileStore2['seller_data']['company_address']}";
      gstNumber2 = "${profileStore2['seller_data']['tax_number']}";
      udyogNumber2 = "${profileStore2['seller_data']['udyog_num']}";
      bussinessCategory2 = "${profileStore2['seller_data']['udyog_num']}";
      country2 = "${profileStore2['data']['country']}";
      state2 = "${profileStore2['data']['state']}";
      district2 = "${profileStore2['data']['destrict']}";
      area2 = "${profileStore2['data']['area']}";
      pinCode2 = "${profileStore2['data']['pincode']}";
      city2 = "${profileStore2['data']['city']}";
      partnerName2 = "${profileStore2['seller_data']['partner']}";
      partnerNumber2 = "${profileStore2['seller_data']['partner_number']}";
      googleAddress2 = "${profileStore2['data']['address']}";
      // anyNumber2="${profileStore2['data']['address']}";
      websiteLink2 = "${profileStore2['seller_data']['web_link']}";
      facebook2 = "${profileStore2['seller_data']['facebook']}";
      insta2 = "${profileStore2['seller_data']['instagram']}";
      linkdin2 = "${profileStore2['seller_data']['linkedin']}";
      yourMobileNumber.text = mNo ?? "";
      mobileNo = mNo ;
    } else {
      print(response.reasonPhrase);
    }
  }

  GetHomeProductsModel? homeProductsModel;

  homeProducts() async {
    var headers = {
      'Cookie': 'ci_session=70e96d2327e44495fa936ae29e0b3378358ed10c'
    };
    var request =
    http.Request('POST', Uri.parse('${ApiService.getHomeProducts}'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse =
      GetHomeProductsModel.fromJson(jsonDecode(finalResponse));

      setState(() {
        homeProductsModel = jsonResponse;
        print('${homeProductsModel?.data?.length}______________');
      });
    } else {
      print(response.reasonPhrase);
    }
  }
  GetHomeCategoryModel? homeCategory;
  homeCategories() async {
    var headers = {
      'Cookie': 'ci_session=a0c4a8147cd6ca589ca5ea95dd55a72e8678d0d2'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiService.getHomeCategories}'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse =
      GetHomeCategoryModel.fromJson(json.decode(finalResponse));
      homeCategory = jsonResponse;
      setState(() {
        homeCategory = jsonResponse;
      });
    } else {
      print(response.reasonPhrase);
    }
  }
  getAdvertisgment() async {
    var headers = {
      'Cookie': 'ci_session=87537d5333112235532d1b40405b3ecb111f87e4'
    };
    var request =
    http.Request('GET', Uri.parse('${ApiService.advertiesgment}'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var store = await response.stream.bytesToString();
      adImages = AdModel.fromJson(json.decode(store));
    } else {
      print(response.reasonPhrase);
    }
  }
  sliderImages() async {
    var headers = {
      'Cookie': 'ci_session=cfaf8a5af69a02ff6166d842c050ff4aa1d64eb1'
    };
    var request =
    http.Request('POST', Uri.parse('${ApiService.getSliderImage}'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var store = await response.stream.bytesToString();
      finalImages = SliderImageModel.fromJson(json.decode(store));
    } else {
      print(response.reasonPhrase);
    }
  }
  HomeSpecificModel? homeSpecificModel;
  getSpecifiyApi() async {
    var headers = {
      'Cookie': 'ci_session=8c39e984ae36f8d6fb6a13958efc01ed44bfa39f'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${baseUrl}home_specific_data'));
    request.fields.addAll({
      'seller_id': userId.toString()
      //'user_id': '517'
    });
    print("111111111111111${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = HomeSpecificModel.fromJson(json.decode(result));
      setState(() {
        homeSpecificModel = finalResult;
      });
    } else {
      print(response.reasonPhrase);
    }
  }
  int? otpNew;

  deleteApi() async {
    var headers = {
      'Cookie': 'ci_session=d969b958bc9745b7bd58ad27651a5ed6faf6eca1'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}delete_account'));
    request.fields.addAll({
      'user_id': userId.toString()
    });
    print("aaaaaaaaaaaaaaaaa${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);
      Fluttertoast.showToast(msg: "${finalResult['message']}");
      if(mounted) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
      }
      // Navigator.pop(context);

    }
    else {
      print(response.reasonPhrase);
    }

  }
  deleteSendOTP() async {

    Uri url =
    Uri.parse("${baseUrl}send_otp");
    var data = {
      'mobile': yourMobileNumber.text,

    };
    var post = await http.post(url, body: data);
    try {
      if (post.statusCode == 200) {
        jsonData = jsonDecode(post.body);
        print(jsonData['error']);
        if (jsonData['error'] == false) {
          otpNew = jsonData['data']['otp'];
          showDialogDeleteOTp(otpNew.toString());
          Fluttertoast.showToast(msg: jsonData['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.black54,
            textColor: Colors.white,
          );
        } else {
          Fluttertoast.showToast(msg: jsonData['message']);

        }
      }


    } catch (e) {
      print(e.toString());
    }
  }
  void deleteVerifyOTP(String otp) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.transparent,
              content: Container(
                height: 250,
                width: MediaQuery.of(context).size.width / 1.5,
                // width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 3,
                  child: Column(
                    children: [
                      Container(
                        color: colors.primary,
                        height: 60,
                        child:  Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Contact Supplier',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'OTP : ${otp}',
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: OtpTextField(
                              numberOfFields: 4,
                              fieldWidth: 20,
                              borderColor: Colors.red,
                              focusedBorderColor: Colors.blue,
                              showFieldAsBox: false,
                              borderWidth: 1,
                              //runs when a code is typed in
                              onCodeChanged: (String code) {
                                print(code);
                                // pinCodeController.text=code;
                                //  controller=code;
                                //handle validation or checks here if necessary
                              },
                              //runs when every textfield is filled
                              onSubmit: (String verificationCode) {
                                controller = verificationCode;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                      Btn(
                        height: 40,
                        width: 150,
                        title: "Verify OTP",
                        onPress: () {
                          if (controller == OTPIS) {

                          } else {
                            Fluttertoast.showToast(msg: 'Enter Correct OTP');
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }
  void showDialogDelete(mobile) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.transparent,
              content: Container(
                height: userId == "null" ? 400 : 250,
                width: MediaQuery.of(context).size.width / 1.2,
                // width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 3,
                  child: Form(
                    key: _Cotact,
                    child: Column(
                      children: [
                        Container(
                          color: colors.primary,
                          height: 60,
                          child: Row(
                            children: const [
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Delete Account',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10),
                              child: TextFormField(
                                maxLength: 10,
                                controller: yourMobileNumber,
                                decoration: InputDecoration(
                                  prefixIcon: const Padding(
                                    padding:
                                    EdgeInsets.only(top: 3),
                                    child: Icon(
                                      Icons.call,
                                      color: colors.primary,
                                      size: 20,
                                    ),
                                  ),
                                  counterText: "",
                                  contentPadding:
                                  const EdgeInsets.only(top: 0, left: 0),
                                  hintText: "Your Mobile",
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(5.0),
                                    borderSide: const BorderSide(),
                                  ),
                                ),
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "mobile cannot be empty";
                                  } else if(val.length < 10){
                                    return "Please enter 10 digit number";

                                  }
                                },
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Btn(
                              height: 40,
                              width: 150,
                              title: "Send OTP",
                              onPress: () {
                                print('__________OTP_________');
                                if (_Cotact.currentState!.validate()) {
                                  deleteSendOTP();
                                  //Navigator.pop(context);
                                }
                              },
                            )
                          ],
                        )



                      ],
                    ),
                  ),
                ),
              ),
            );
          });
        });
  }

  void showDialogDeleteOTp(String otp) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.transparent,
              content: Container(
                height: 250,
                width: MediaQuery.of(context).size.width / 1.5,
                // width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 3,
                  child: Column(
                    children: [
                      Container(
                        color: colors.primary,
                        height: 60,
                        child: Row(
                          children: const [
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Delete Account',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'OTP : ${otpNew}',
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: OtpTextField(
                              numberOfFields: 4,
                              fieldWidth: 20,
                              borderColor: Colors.red,
                              focusedBorderColor: Colors.blue,
                              showFieldAsBox: false,
                              borderWidth: 1,
                              //runs when a code is typed in
                              onCodeChanged: (String code) {
                                print(code);
                                // pinCodeController.text=code;
                                //  controller=code;
                                //handle validation or checks here if necessary
                              },
                              //runs when every textfield is filled
                              onSubmit: (String verificationCode) {
                                controllerDelete = verificationCode;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                      Btn(
                        height: 40,
                        width: 150,
                        title: "Verify OTP",
                        onPress: () {
                          if (controllerDelete == otpNew.toString()) {
                            print("object");
                            deleteApi();
                            Navigator.pop(context);
                          } else {
                            Fluttertoast.showToast(msg: 'Enter Correct OTP');
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }
}
