// import 'package:b2b/fourth.dart';
// import 'package:b2b/sixth.dart';
import 'dart:convert';
import 'package:b2b/Constant/Constants.dart';
import 'package:b2b/Model/login_response_model.dart';
import 'package:b2b/apiServices/apiConstants.dart';
import 'package:b2b/widgets/appButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';

// import 'package:otp_text_field/otp_field.dart';
// import 'package:otp_text_field/style.dart';
// import 'package:pinput/pinput.dart';
import 'package:http/http.dart' as http;
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../color.dart';

import '../Screen/HomeScreen.dart';
import 'login.dart';

var store2;
String? otp;
String? mobileNumber;

String? controller;
String? userName;
String? email;
String? mobile;
String? sessionId;
String? companyName;
String? bussinessAddress;
String? gstNumber;
String? udyogNumber;
String? bussinessCategory;
String? country;
String? state;
String? district;
String? area;
String? pinCode;
String? city;
String? partnerName;
String? partnerNumber;
String? googleAddress;
String? anyNumber;
String? websiteLink;
String? facebook;
String? insta;
String? linkdin;

var username2;
var email2;
var mobile2;
var profileStore2;

LoginPage loginPage = LoginPage();
TextEditingController pinCodeController = new TextEditingController();

class OtpVerify extends StatefulWidget {

  String currentOtp;
  String mobileNo;

  OtpVerify({required this.currentOtp, required this.mobileNo});

  @override
  // void dispose() {
  //   pinCodeController.dispose();
  // }

  State<OtpVerify> createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> {
  OtpFieldController  pinController = OtpFieldController();
  int pinCodeLength =
      4; // Change this value to set the desired length of the PIN code
  @override
  void initState() {
    // TODO: implement initState
    pinCodeController.clear();
    super.initState();
  }
  String? otpPin;
  @override
  Widget build(BuildContext context) {
    var _mediaquery = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
            title: const Text(
              "Verification",
              style: TextStyle(fontSize: 20, letterSpacing: 1.0),
            ),
            centerTitle: true,
            backgroundColor: colors.primary),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 78.0),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "Code has sent to",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25.0),
                  child: Text(
                    "${widget.mobileNo}",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5),
                  ),
                ),
                Text("OTP:${widget.currentOtp}"),

                // OtpTextField(
                //   numberOfFields: 6,
                //   borderColor: Colors.red,
                //   focusedBorderColor: Colors.blue,
                //   showFieldAsBox: false,
                //   borderWidth: 2.0,
                //   onCodeChanged: (String verificationCode) {
                //     verificationCode;
                //   },
                // ),
                Padding(
                  padding: const EdgeInsets.only(left: 30,right: 30),
                  child: OTPTextField(
                    outlineBorderRadius: 50 ,
                    controller:pinController,
                    //otpFieldStyle: OtpFieldStyle(backgroundColor:colors.white,borderColor:colors.white),
                    length: 6,
                    keyboardType: TextInputType.number,
                    width: MediaQuery.of(context).size.width,
                    fieldWidth: 45,
                    //style: const TextStyle(fontSize: 17,color: colors.white),
                    //textFieldAlignment: MainAxisAlignment.spaceAround,
                    //fieldStyle: FieldStyle.box,
                    onChanged: (val) {
                      print("Completed: " + val);

                      setState(() {
                        otpPin = val.toString().trim() ;
                      });
                    },
                  ),
                ),


                const Padding(
                  padding: EdgeInsets.only(top: 50, bottom: 5),
                  child: Text(
                    "Haven't received the verification code?",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                ),
                InkWell(
                  onTap: () {
                    postData(context);
                  },
                  child: const Text("Resend",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                ),
                SizedBox(
                  height: 50,
                ),

                Btn(
                  height: 50,
                  width: 250,
                  title: isLodding == true ? 'Please wait....' : "Verify Authentication Code",
                  onPress: () {
                         print('____ssssss______${widget.currentOtp.toString() == otpPin.toString()}_________');
                         print('____ssssss______${widget.currentOtp.toString()}_________');
                         print('____ssssss______${otpPin}_________');
                    if (otpPin == null && otpPin.toString().length > 2) {
                      final snackBar = SnackBar(content: Text('Please Enter OTP'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else if(widget.currentOtp.toString() == otpPin.toString()) {
                      verifyData();
                      setState(() {
                        isLodding = false;
                      });
                    } else {
                      final snackBar = SnackBar(content: Text('Please Enter Correct Otp'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      setState(() {
                        isLodding = false;
                      });
                    }
                  },
                )
                // Btn(
                //   height: 50,
                //   width: 300,
                //   title: isLodding == true
                //       ? "Please wait..."
                //       : 'Verify Authentication Code',
                //   onPress: () {
                //
                //   },
                // )
                // Padding(
                //   padding: const EdgeInsets.only(
                //     top: 48,
                //   ),
                //   // child: InkWell(
                //   //   onTap: () {
                //   //     verifyData();
                //   //     print("${widget.currentOtp}");
                //   //     // Navigator.push(context, MaterialPageRoute(builder: (context)=>Sixth()));
                //   //   },
                //
                //
                //     child: InkWell(
                //       onTap: () async{
                //
                //        //mobileNumber = mobile;
                //        //  final SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
                //        // sharedPreferences.setString('otp1', pinCodeController.text);
                //        // Navigator.push(context, MaterialPageRoute(builder: (context)=>B2BHome()));
                //         // print("$mobileController.text");
                //
                //       },
                //       child: Container(
                //         width: 310,
                //         height: 48,
                //         decoration: BoxDecoration(
                //           color: colors.primary,
                //           borderRadius: BorderRadius.circular(14),
                //         ),
                //         child: const Center(
                //             child: Text(
                //           "Verify Authentication Code",
                //           style: TextStyle(
                //               fontSize: 19,
                //               fontWeight: FontWeight.w500,
                //               color: Colors.white),
                //         )),
                //       ),
                //     ),
                //   ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  postData(BuildContext context) async {
    Uri url =
    Uri.parse("${baseUrl}login");
    var data = {
      'mobile': widget.mobileNo,
    };
    var post = await http.post(url, body: data);
    try {
      if (post.statusCode == 200) {
        jsonData = jsonDecode(post.body);
        print(jsonData['error']);
        if (jsonData['error'] == false) {
          setState(() {
            widget.currentOtp  = jsonData['otp'];
          });
          print(otp);
          final snackBar = SnackBar(content: Text('OTP send successfully'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          Fluttertoast.showToast(msg: jsonData['message']);
        }

      }
      print("${jsonData.message}");
      print("${mobileController.text}===========");

      //  print("Data uploaded");
    } catch (e) {
      print(e.toString());
    }
  }
  getProfile() async {
    var headers = {
      'Cookie': 'ci_session=60e6733f1ca928a67f86820b734e34f4e5e0dd4e'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse('${baseUrl}get_profile'));
    request.fields.addAll({'user_id': '${sessionId}'});

    print(
        "sign up details para ${request.fields}==========================================================");

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result2 = await response.stream.bytesToString();
      var profileStore = jsonDecode(result2);
      setState(() {
        profileStore2 = profileStore;
        // print("${store2}");
      });
    }
    if (profileStore2['error'] == false) {
    } else {
      print(response.reasonPhrase);
    }
  }

  bool? isLodding = false;
  LoginSuccessResponse? _loginSuccessResponse;

  verifyData() async {
    setState(() {
      isLodding = true;
    });
    var headers = {
      'Cookie': 'ci_session=228544e29bd38db4392fc21e8bf90e7adb898615'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse('${baseUrl}verify_user'));
    request.fields.addAll({
      'mobile': '${widget.mobileNo}',
      'otp': widget.currentOtp
      // '${pinCodeController.text}',
    });
    print('__________sssss___${request.fields}______');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      print(result);
      var store = jsonDecode(result);
      setState(() {
        store2 = store;
      });

      if (store['error'] == false) {
        print('__________error_________');
        _loginSuccessResponse = LoginSuccessResponse.fromJson(store);
        userName = _loginSuccessResponse?.data?.username ?? '';
        email = _loginSuccessResponse?.data?.email ?? '';
        mobile = _loginSuccessResponse?.data?.mobile ?? '';
        setState(() {
          sessionId = _loginSuccessResponse?.data?.id ?? '';
        });
        userId = _loginSuccessResponse?.data?.id ?? '';

        ////////////////////////// companyName=store['data']['id'];
        bussinessAddress = _loginSuccessResponse?.data?.address ?? '';
        gstNumber = _loginSuccessResponse?.sellerData?.taxNumber ?? '';
        udyogNumber = _loginSuccessResponse?.sellerData?.udyogNum ?? '';
        bussinessCategory = _loginSuccessResponse?.data?.typeOfSeller ?? '';
        country = _loginSuccessResponse?.data?.country ?? '';
        state = _loginSuccessResponse?.data?.state ?? '';
        district = _loginSuccessResponse?.data?.destrict ?? '';
        area = _loginSuccessResponse?.data?.area ?? '';
        pinCode = _loginSuccessResponse?.data?.pincode ?? '';
        city = _loginSuccessResponse?.data?.city ?? '';
        partnerName = _loginSuccessResponse?.sellerData?.partner ?? '';
        partnerNumber = _loginSuccessResponse?.sellerData?.panNumber ?? '';
        googleAddress = _loginSuccessResponse?.sellerData?.partnerAddress ?? '';
        //////////////// anyNumber=store['data']['id'];
        //////////////// websiteLink=store['data']['id'];
        facebook = _loginSuccessResponse?.sellerData?.facebook ?? '';
        insta = _loginSuccessResponse?.sellerData?.instagram ?? '';
        linkdin = _loginSuccessResponse?.sellerData?.linkedin ?? '';
        final SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString('id', sessionId ?? '');
        sharedPreferences.setString('username', userName ?? '');
        sharedPreferences.setString('email', email ?? '');
        sharedPreferences.setString('mobile', mobile ?? '');
        sharedPreferences.setString('gstNumber', gstNumber ?? '');
        sharedPreferences.setString('udyogNumber', udyogNumber ?? '');
        sharedPreferences.setString(
            'bussinessCategory', bussinessCategory ?? '');
        sharedPreferences.setString('country', country ?? '');
        sharedPreferences.setString('state', state ?? '');
        sharedPreferences.setString('district', district ?? '');
        sharedPreferences.setString('area', area ?? '');
        sharedPreferences.setString('pinCode', pinCode ?? '');
        sharedPreferences.setString('city', city ?? '');
        sharedPreferences.setString('partnerName', partnerName ?? '');
        sharedPreferences.setString('partnerNumber', partnerNumber ?? '');
        sharedPreferences.setString('googleAddress', googleAddress ?? '');
        sharedPreferences.setString('facebook', facebook ?? '');
        sharedPreferences.setString('insta', insta ?? '');
        sharedPreferences.setString('linkdin', linkdin ?? '');
        final snackBar = SnackBar(content: Text('OTP Verify Successfully'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => B2BHome()));

        setState(() {
          isLodding = false;
        });
        //  Navigator.push(context, MaterialPageRoute(builder: (context)=>B2BHome()));
      }
    } else {
      setState(() {
        isLodding = false;
      });
      print(response.reasonPhrase);
    }
  }
}
