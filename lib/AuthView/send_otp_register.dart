import 'dart:convert';

import 'package:b2b/AuthView/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../apiServices/apiConstants.dart';
import '../widgets/Appbar.dart';
import '../widgets/appButton.dart';
import '../Screen/HomeScreen.dart';
import '../AuthView/detail.dart';
import '../AuthView/otp_verify.dart';

class SendOtpRegister extends StatefulWidget {
  SendOtpRegister({
    Key? key,
    this.name,
    this.otp,
    this.mobile,
    this.email,
  }) : super(key: key);
  int? otp;
  String? name, mobile, email;

  @override
  State<SendOtpRegister> createState() => _SendOtpRegisterState();
}

class _SendOtpRegisterState extends State<SendOtpRegister> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    otpis = widget.otp.toString();
  }

  String? otpPin;
  var otpis = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            customAppBar(text: "Verification", isTrue: false, context: context),
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
                    "+91${widget.mobile}",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.normal,
                        letterSpacing: 1.5),
                  ),
                ),
                Text("OTP:${widget.otp}"),
                OtpTextField(
                  numberOfFields: 6,
                  borderColor: Colors.red,
                  focusedBorderColor: Colors.blue,
                  showFieldAsBox: false,
                  borderWidth: 2.0,
                  // onCodeChanged: (String code) {
                  //
                  // },
                  onSubmit: (String verificationCode) {
                    otpPin = verificationCode;
                  },
                ),

                const Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 5),
                  child: Text(
                    "Haven't received the verification code?",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                ),
                InkWell(
                  onTap: () {
                    resendApi();
                  },
                  child: const Text("Resend",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                ),
                SizedBox(
                  height: 20,
                ),
                Btn(
                  height: 50,
                  width: 120,
                  title: isloader ? 'Please wait....' : "Verify OTP",
                  onPress: () {
                    if (/*otpPin.toString() == 'null' || */otpPin == null) {
                      final snackBar = SnackBar(content: Text('Please Enter OTP'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else if (widget.otp.toString() == otpPin.toString()) {
                      setState(() {
                        isloader = true;
                      });
                      final snackBar = SnackBar(content: Text('OTP Verify Successfully'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailPage(
                                  userName: widget.name,
                                  userMobile: widget.mobile,
                                  userEmail: widget.email)));
                      setState(() {
                        isloader = false;
                      });
                    } else {
                      final snackBar = SnackBar(content: Text('Please Enter Correct Otp'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      setState(() {
                        isloader = false;
                      });
                    }
                  },
                )
              ],
            ),
          ),
        ));
  }

  bool isloader = false;

  // yourSuggestionApi() async {
  //   setState(() {
  //     isloader = true;
  //   });
  //   var headers = {
  //     'Cookie': 'ci_session=44d4fd636c908489b8d891063699a4f4786cfe01'
  //   };
  //   var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}your_suggestion'));
  //   request.fields.addAll({
  //     'name': widget.name.toString(),
  //     'city': widget.city.toString(),
  //     'mobile': widget.mobile.toString(),
  //     'message': widget.messges.toString()
  //   });
  //   request.headers.addAll(headers);
  //   http.StreamedResponse response = await request.send();
  //
  //   if (response.statusCode == 200) {
  //     var result =  await response.stream.bytesToString();
  //     var finalResult =  jsonDecode(result);
  //     Fluttertoast.showToast(msg: "${finalResult['message']}");
  //     Navigator.push(context, MaterialPageRoute(builder: (context)=>B2BHome()));
  //     setState(() {
  //       isloader = false;
  //     });
  //   }
  //   else {
  //     setState(() {
  //       isloader = false;
  //     });
  //   }
  //   print(response.reasonPhrase);
  // }

  resendApi() async {
    var headers = {
      'Cookie': 'ci_session=8223a0a912b28e1bd33e12b26ed6d22709673b24'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse('${baseUrl}resend_otp'));
    request.fields.addAll({'mobile': widget.mobile.toString()});
    print('_____this mobile No_____${request.fields}_________');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);
      setState(() {
        widget.otp = finalResult['data']['otp'];
      });
      print('____there is otp______${widget.otp}_________');
    } else {
      print(response.reasonPhrase);
    }
  }
// var jsonData;
// postData(BuildContext context) async {
//   Uri url =
//   Uri.parse("${baseUrl}resend_otp");
//   var data = {
//     'mobile': widget.mobile.toString(),
//   };
//   var post = await http.post(url, body: data);
//   try {
//     if (post.statusCode == 200) {
//       jsonData = jsonDecode(post.body);
//       print(jsonData['error']);
//       if (jsonData['error'] == false) {
//         // print("${mobileController.text}");
//         setState(() {
//           otpis = jsonData['otp'].toString();
//         });
//         print('_____ssss_____${otpis}_________');
//         // print(jsosnData['data'][0]['username']);
//         //  print("trueeeeeeeeeeeeeeeeeeeee");
//         print(otp);
//         //
//         // jsonData == null
//         //     ? const CircularProgressIndicator()
//         //     : Navigator.push(
//         //     context,
//         //     MaterialPageRoute(
//         //         builder: (context) => OtpVerify(
//         //           currentOtp: '${otp}',
//         //           mobileNo: '${mobileController.text}',
//         //         )));
//
//
//
//         // Navigator.push(
//         //     context, MaterialPageRoute(builder: (context) => OtpVerify()));
//         Fluttertoast.showToast(
//           msg: jsonData['message'],
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.BOTTOM,
//           backgroundColor: Colors.black54,
//           textColor: Colors.white,
//         );
//       } else {
//         Fluttertoast.showToast(msg: jsonData['message']);
//       }
//       // }else {
//       //   print('field');
//     }
//     print("${jsonData.message}");
//     print("${mobileController.text}===========");
//
//     //  print("Data uploaded");
//   } catch (e) {
//     print(e.toString());
//   }
// }
}
