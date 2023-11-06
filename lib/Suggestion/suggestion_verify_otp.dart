import 'dart:convert';

import 'package:b2b/AuthView/register.dart';
import 'package:b2b/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import '../apiServices/apiConstants.dart';
import '../widgets/Appbar.dart';
import '../widgets/appButton.dart';
import '../Screen/HomeScreen.dart';
import '../AuthView/detail.dart';
import '../AuthView/otp_verify.dart';

class SuggestionVerifyOtp extends StatefulWidget {
  SuggestionVerifyOtp(
      {Key? key, this.name, this.otp,  this.city, this.messges,this.mobile,})
      : super(key: key);
  int? otp;
  String? name,  city, messges, mobile;

  @override
  State<SuggestionVerifyOtp> createState() => _SuggestionVerifyOtpState();
}

class _SuggestionVerifyOtpState extends State<SuggestionVerifyOtp> {
  String? otpPin;

  @override
  Widget build(BuildContext context) {
    print(widget.mobile);
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
                  numberOfFields: 4,
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
                SizedBox(height: 20),
                InkWell(
                  onTap: (){
                    resendOtp();
                  },
                    child: Text("Resend OTP",style: TextStyle(color: colors.black,fontWeight: FontWeight.bold),)),
                SizedBox(height: 10),
                Btn(
                  height: 50,
                  width: 120,
                  title: isloader == true ? 'Please wait....':"Verify OTP",
                  onPress: () {
                    if(widget.otp.toString() == otpPin.toString()){

                      yourSuggestionApi();
                    }else{
                         Fluttertoast.showToast(msg: "Otp not match");
                    }
                  },
                )
              ],
            ),
          ),
        ));
  }

  int? Otp;
  String? cityName,mobileNo,name,message;
resendOtp() async {
  var headers = {
    'Cookie': 'ci_session=37dc02e2434d2d73666378f5f07f96a7862cdcb7'
  };
  var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}send_otp'));
  request.fields.addAll({
    'mobile': widget.mobile.toString()
  });

  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    var result = await response.stream.bytesToString();
    var finalResult =  jsonDecode(result);
    setState(() {
      widget.otp =  finalResult['data']['otp'];
    });

   print('____scsdfsfsd______${widget.otp}_________');
  }
  else {
  print(response.reasonPhrase);
  }

}
  bool isloader =  false;
  yourSuggestionApi() async {
    setState(() {
      isloader = true;
    });
    var headers = {
      'Cookie': 'ci_session=44d4fd636c908489b8d891063699a4f4786cfe01'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}your_suggestion'));
    request.fields.addAll({
      'name': widget.name.toString(),
      'city': widget.city.toString(),
      'mobile': widget.mobile.toString(),
      'message': widget.messges.toString()
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result =  await response.stream.bytesToString();
      var finalResult =  jsonDecode(result);
      Fluttertoast.showToast(msg: "${finalResult['message']}");
      Navigator.push(context, MaterialPageRoute(builder: (context)=>B2BHome()));
      setState(() {
        isloader = false;
      });
    }
    else {
      setState(() {
        isloader = false;
      });
    }
      print(response.reasonPhrase);
    }

  }
