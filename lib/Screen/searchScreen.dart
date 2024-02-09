import 'dart:convert';
import 'dart:math';

import 'package:b2b/Constant/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Model/SearchModel.dart';
import '../apiServices/apiConstants.dart';
import '../color.dart';
import '../utils/design_config.dart';
import '../widgets/appButton.dart';
import 'HomeScreen.dart';
import 'Product_details_home.dart';


class SearchScreen extends StatefulWidget {
   SearchScreen({Key? key,this.selectedCity}) : super(key: key);
    String? selectedCity;


  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  TextEditingController searchC = TextEditingController();

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
        searchApi();
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
  bool currentIndex = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          // appBar: customAppBar(context: context, text: "Search", isTrue: false),
          body:Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  width:
                  MediaQuery.of(context).size.width / 1.1,
                  height: 50,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(
                    bottom: 10,
                  ),
                  child: TextField(
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
                          initSpeechState();
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
                      searchApi();
                    },
                  ),
                ),
              ),
              getSubcat(),
            ],
          )

      ),
    );
  }

  getSubcat() {
    return Container(
      padding: const EdgeInsets.only(top: 0, left: 12, right: 12),
      child:  SizedBox(
        height: MediaQuery.of(context).size.height / 1.2,
        //  GetSub!.data![i].products!.length >3? 280:140,
        child: isProducts ? const Center(child: CircularProgressIndicator(),)
            : searchList.isEmpty ?
        const Center(child: Text('No Products found!'))
            : searchList.isNotEmpty ?
        ListView.builder(
            shrinkWrap: true,

            physics: const ScrollPhysics(),
            itemCount: searchList.length,
            //> 6 ? 6 : GetSub!.data![i].products!.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetailsHome(pId: searchList![index].id)));
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
                              "${searchList[index].image}" ??
                                  '',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 24, top: 10),
                          child: Text(
                            "${searchList[index].name}" ??
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
                                        "${searchList[index].storeName}" ?? ''),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                        width: 120,
                                        child: Text(
                                          "(${searchList[index].typeOfSeller})" ??
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
                                    "${searchList[index].sellerAddress}" ??
                                        "",
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
                                        "${searchList[index].video}");
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons
                                            .video_camera_back_outlined,
                                        color: colors.primary,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const InkWell(
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
                                                content:searchList[index].broucherImage == null ? Image.asset("Images/no-image-icon.png",height: 120,width:double.infinity,fit: BoxFit.fill,):
                                                Image.network(
                                                    "${searchList[index].broucherImage}"),
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
                                    color: Colors
                                        .deepPurple),
                                child: const Icon(
                                  Icons.add_circle,
                                  size: 15,
                                  color: Colors.white,
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
                                          color: searchList[index].taxNumber == ""
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
                                          color: searchList[index]
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
                                          color:searchList[index]
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
                              showDialogContactSuplier(
                                  searchList[index].id.toString(),
                                  mobileNo);
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            })
            : const Center(
          child: SizedBox(
            height: 30,
            width: 30,
            child: CircularProgressIndicator(
              color: colors.primary,
            ),
          ),
        ),
      ),
    );
  }
  List<SearchData> searchList = [];
  bool isProducts = false;

 Future<void> searchApi() async {
   isProducts = true ;
   setState(() {});
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}fetch_product_by_fillters'));
    request.fields.addAll({
      'name': searchC.text.toString(),
      'city': widget.selectedCity == "Select All City" ? 'select_all_city' : widget.selectedCity ?? 'select_all_city'
    });
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      // String responseData = await response.stream.transform(utf8.decoder).join();
      var userData = json.decode(result);
      // var result = await response.stream.bytesToString();
      var finalResult = SearchModel.fromJson(userData);
      debugPrint('____request______${request.fields}');
      debugPrint('____searchResult______${result}');


      setState(() {
        isProducts = false;
        searchList = finalResult.data!;
      });

    } else {
      print(response.reasonPhrase);
      isProducts = false;
      setState(() {

      });

    }
  }


  TextEditingController pinCodeController =  TextEditingController();
  final _Cotact = GlobalKey<FormState>();

  TextEditingController yournamecontroller = TextEditingController();
  TextEditingController yourMobileNumber = TextEditingController();
  TextEditingController YourcityController = TextEditingController();
  bool verifie = false;
  String? controller;
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

  void showDialogContactSuplier(String productId, String? mobile) async {
    yourMobileNumber.text = mobile ?? '' ;
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.transparent,
              content: Container(
                height: userId != "null" ? 250 : 400,
                width: MediaQuery.of(context).size.width / 1.5,
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
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10),
                              child: TextFormField(
                                maxLength: 10,
                                readOnly: true,
                                controller: yourMobileNumber,
                                decoration:  InputDecoration(
                                  contentPadding:
                                  const EdgeInsets.only(top: 5, left: 5),
                                  hintText: "Your Mobile",
                                  fillColor: Colors.white,
                                  border:  OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(5.0),
                                    borderSide:  const BorderSide(),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Mobile Number';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.name,
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
                                decoration:  InputDecoration(
                                  contentPadding:
                                  const EdgeInsets.only(top: 5, left: 5),
                                  hintText: "Your Name",
                                  fillColor: Colors.white,
                                  border:  OutlineInputBorder(
                                    borderRadius:
                                     BorderRadius.circular(5.0),
                                    borderSide:  const BorderSide(),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Name';
                                  }
                                  return null;
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
                                  counterText: "",
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
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Mobile Number';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
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
                                decoration:  InputDecoration(
                                  contentPadding:
                                  const EdgeInsets.only(top: 5, left: 5),
                                  hintText: "Your City",
                                  fillColor: Colors.white,
                                  border:  OutlineInputBorder(
                                    borderRadius:
                                     BorderRadius.circular(5.0),
                                    borderSide:  BorderSide(),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter City';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.name,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        Btn(
                          height: 45,
                          width: 150,
                          title: "Send OTP",
                          onPress: () {

                            if (_Cotact.currentState!.validate()) {
                              print("gggggggggggggggg");
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
                height: 350,
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
                      InkWell(
                        onTap: () {
                          if (controller == OTPIS) {
                            sendEnqury(productIddd);
                          } else {
                            Fluttertoast.showToast(msg: 'Enter Correct OTP');
                          }
                        },
                        child: Container(
                          color: colors.primary,
                          width: 100,
                          height: 40,
                          child: const Center(
                              child: Text(
                                'Verify Otp',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
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
}
