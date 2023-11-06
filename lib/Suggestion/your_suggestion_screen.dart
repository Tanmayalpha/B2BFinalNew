import 'dart:convert';

import 'package:b2b/Suggestion/suggestion_verify_otp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../apiServices/apiConstants.dart';
import '../widgets/Appbar.dart';
import 'package:http/http.dart'as http;

import '../widgets/appButton.dart';
import '../AuthView/detail.dart';
import '../AuthView/otp_verify.dart';

class YourSuggestion extends StatefulWidget {
  const YourSuggestion({Key? key}) : super(key: key);

  @override
  State<YourSuggestion> createState() => _YourSuggestionState();
}

class _YourSuggestionState extends State<YourSuggestion> {
  TextEditingController nameC = TextEditingController();
  TextEditingController mobileC = TextEditingController();
  TextEditingController cityC = TextEditingController();
  TextEditingController messageC = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isloader = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(text: "Your Suggestion",isTrue: false, context: context),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Theme(
                  data: new ThemeData(
                    primaryColor: Colors.red,
                    primaryColorDark: Colors.black,
                  ),
                  child: TextFormField(
                    controller: nameC,
                    decoration: new InputDecoration(
                      hintText: "Your Name",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide: new BorderSide(),
                      ),

                    ),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "name cannot be empty";
                      } else if(val.length < 3){
                        return "Please enter 3 digit name";

                      }
                    },
                    keyboardType: TextInputType.name,
                  ),
                ),
                SizedBox(height: 10,),
                Theme(
                  data: new ThemeData(
                    primaryColor: Colors.red,
                    primaryColorDark: Colors.black,
                  ),
                  child: TextFormField(
                    maxLength: 10,
                    controller: mobileC,
                    decoration: new InputDecoration(
                      counterText: "",
                      hintText: "Your Mobile",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide: new BorderSide(),
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
                SizedBox(height: 10,),
                Theme(
                  data: new ThemeData(
                    primaryColor: Colors.red,
                    primaryColorDark: Colors.black,
                  ),
                  child: TextFormField(
                    controller: cityC,
                    decoration: new InputDecoration(
                      hintText: "Your City",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide: new BorderSide(),
                      ),

                    ),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "city cannot be empty";
                      } else if(val.length < 3){
                        return "Please enter 3 digit city";

                      }
                    },
                    keyboardType: TextInputType.name,
                  ),
                ),
                SizedBox(height: 10,),
                Theme(
                  data: new ThemeData(
                    primaryColor: Colors.red,
                    primaryColorDark: Colors.black,
                  ),
                  child: TextFormField(
                    controller: messageC,
                    decoration: new InputDecoration(
                      hintText: "Message",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide: new BorderSide(),
                      ),

                    ),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Message cannot be empty";
                      } else if(val.length < 3){
                        return "Please enter 3 digit Message";

                      }
                    },
                    keyboardType: TextInputType.name,
                  ),
                ),
                SizedBox(height: 50,),
                Btn(
                  height: 50,
                  width: 150,
                  title: isloader == true ? "Please wait......" :"Send OTP",
                onPress: (){
                  if(_formKey.currentState!.validate()) {
                    yourSuggestionSendApi();
                  }else{
                    setState(() {
                      isloader = false;
                    });
                    Fluttertoast.showToast(
                        msg:
                        "all fields are required!!");
                  }

                },)
              ],


            ),
          )
        ),
      ),
    );
  }
  int? Otp;
  String? cityName,mobileNo,name,message;
  yourSuggestionSendApi() async {
    setState(() {
      isloader = true;
    });
    Uri url =
    Uri.parse("${baseUrl}send_otp");
    var data = {
      'mobile': mobileC.text,
      'city': cityC.text,
      'name': nameC.text,
      'message': messageC.text,
    };
    var post = await http.post(url, body: data);
    try {
      if (post.statusCode == 200) {
        jsonData = jsonDecode(post.body);
       // print(jsonData['error']);
        if (jsonData['error'] == false) {
          Otp = jsonData['data']['otp'];
          cityName = jsonData['data']['city'];
          mobileNo = jsonData['data']['mobile'];
          message = jsonData['data']['message'];
          name = jsonData['data']['name'];
          //print('___surendra_______${Otp}_____${cityName}___${mobileNo}_${message}_${name}_');
          jsonData == null
              ? const CircularProgressIndicator()
              : Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SuggestionVerifyOtp(name: name,otp: Otp,city: cityName,messges: message,mobile: mobileNo))
          );
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
      setState(() {
        isloader = false;
      });

    } catch (e) {
      print(e.toString());
    }
  }
}
