import 'dart:convert';
import 'package:b2b/apiServices/apiConstants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../Screen/HomeScreen.dart';
import 'otp_verify.dart';
import '../color.dart';

TextEditingController mobileController = new TextEditingController();
var jsonData;
var otp;
var store3;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool tru = false;

  @override
  void initState() {
    // TODO: implement initState
    mobileController.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Stack(
                children: [
                  Image.asset('Images/bg-4.png'),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          tru = true;
                        });
                        Future.delayed(Duration(seconds: 3), () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => B2BHome()));
                          setState(() {
                            tru = false;
                          });
                        });
                      },
                      child: tru == true
                          ? CircularProgressIndicator(
                              color: colors.black,
                            )
                          : Text(
                              'Skip',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                    ),
                  ),
                  SizedBox(height: 10,),


                   Positioned(
                    top: 20,
                    left: 100,
                    child:  Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Center(child: Image.asset("Images/loginlogo.png",scale: 3,)),
                    ),
                  ),

//Center Container
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 25, right: 25, bottom: 300, top: 150),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        border: Border.all(color: Theme.of(context).focusColor),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.9))
                        ],
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
//Welcome
                            const Padding(
                              padding: EdgeInsets.only(top: 30),
                              child: Text(
                                'Welcome!',
                                style: TextStyle(
                                  color: colors.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40,
                                ),
                              ),
                            ),

//Login to continue
                            const Text(
                              'login in to continue',
                              style: TextStyle(
                                  color: Colors.black26,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),

//Text Input Number

                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 100, left: 30, bottom: 50, right: 30),
                              child: Form(
                                key: _formKey,
                                child: TextFormField(
                                  cursorColor: Colors.black,
                                  keyboardType: TextInputType.number,
                                  controller: mobileController,
                                  maxLength: 10,
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
                                    hintText: 'Mobile Number',
                                    hintStyle: TextStyle(color: Colors.black26),
                                    prefixIcon: Icon(Icons.phone),
                                    prefixIconColor: Colors.black38,
                                  ),
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "mobile cannot be empty";
                                    } else if(val.length < 10){
                                      return "Please enter 10 digit number";

                                    }
                                  },
                                  // inputFormatters: <TextInputFormatter>[
                                  //   LengthLimitingTextInputFormatter(10),
                                  //   FilteringTextInputFormatter.allow(
                                  //     RegExp(r'[0-9]'),
                                  //   ),
                                  //   FilteringTextInputFormatter.digitsOnly
                                  // ],
                                ),
                              ),
                            ),
//Send otp

                            Padding(
                              padding: const EdgeInsets.all(28.0),
                              child: InkWell(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      isloading = true;

                                    });
                                    print("jjjjjjjjjjjjjjjj");
                                    postData(context);

                                    Future.delayed(
                                      Duration(seconds: 2),
                                      () {
                                        setState(() {
                                          isloading = false;
                                        });
                                      },
                                    );
                                  }

                                  if (kDebugMode) {
                                    print("Uploaded");
                                  }
                                },
                                child: Container(
                                  width: 220,
                                  height: 42,
                                  decoration: BoxDecoration(
                                      color: colors.primary,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                      child: isloading
                                          ? Text(
                                              "Please Wait...",
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                              ),
                                            )
                                          : Text(
                                              "Send OTP",
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                              ),
                                            )),
                                ),
                              ),
                            ), //Padding(
//
                          ],
                        ),
                      ),
                    ),
                  ),

                  //  Free Registration or Don't have an account
                  Container(
                    padding: EdgeInsets.only(left: 140, top: 620),
                    child: const Text(
                      'Free Registration',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
//Don't have an account
                  Container(
                    padding: EdgeInsets.only(left: 100, top: 630),
                    child: Row(
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(
                              color: Colors.black26,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'register');
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                                color: colors.primary,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

bool isloading = false;

postData(BuildContext context) async {
  print("fdvfvf");
  Uri url = Uri.parse("${baseUrl}login");
  var data = {
    'mobile': mobileController.text,
  };
  var post = await http.post(url, body: data);
  try {
    if (post.statusCode == 200) {
      jsonData = jsonDecode(post.body);
      if (jsonData['error'] == false) {
        otp = jsonData['otp'];
        print("Surendra");

        final snackBar = SnackBar(content: Text('OTP send successfully'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        jsonData == null
            ? const CircularProgressIndicator()
            : Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OtpVerify(
                          currentOtp: '${otp}',
                          mobileNo: '${mobileController.text}',
                        )));
      } else {
        final snackBar = SnackBar(content: Text('User Not Exist'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // Fluttertoast.showToast(msg: "${jsonData['message']}");
      }
    }
  } catch (e) {
    print(e.toString());
  }
}
