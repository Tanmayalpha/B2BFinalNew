import 'dart:convert';
import 'package:b2b/AuthView/send_otp_register.dart';
import 'package:b2b/apiServices/apiConstants.dart';
import 'package:b2b/widgets/multi_select_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../color.dart';
import '../widgets/appButton.dart';
import 'detail.dart';

var jsonData;
var store;
// final _formKey = GlobalKey<FormState>();

TextEditingController nameController = TextEditingController();
TextEditingController mobileController = TextEditingController();
TextEditingController emailController = TextEditingController();

String? name;
String? mobile;
String? email;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

// final _formKey = GlobalKey<FormState>();

class _RegisterPageState extends State<RegisterPage> {
  @override
  void initState() {
    nameController.text = '';
    emailController.text = '';
    mobileController.text = '';

    // TODO: implement initState
    super.initState();
  }

  // void dispose() {
  //   nameController.dispose();
  //   nameController.clear();
  //   super.dispose();
  // }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
//Image
                  Image.asset('Images/bg-4.png'),
//B2BDiary
//                   Positioned(
//                     top: 20,
//                     left: 80,
//                     child:  Padding(
//                       padding: const EdgeInsets.only(top: 10),
//                       child: Center(child: Image.asset("Images/loginlogo.png",scale: 3,)),
//                     ),
//                   ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 25, right: 25, bottom: 300, top: 150),
                    child: Container(
                      // height: 510,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.9))
                        ],
                        border: Border.all(color: Theme.of(context).focusColor),
                      ),
                      child: Center(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Center(
                                    child: Image.asset(
                                  "Images/loginlogo.png",
                                  scale: 4,
                                )),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  'Welcome!',
                                  style: TextStyle(
                                    color: colors.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 33,
                                  ),
                                ),
                              ),
                              const Center(
                                child: Text(
                                  'Sign Up in to continue',
                                  style: TextStyle(
                                      color: Colors.black26,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 30, bottom: 10, right: 30),
                                child: TextFormField(
                                  controller: nameController,
                                  cursorColor: Colors.black,
                                  keyboardType: TextInputType.multiline,
                                  decoration: const InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black26),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black26),
                                    ),
                                    hintText: 'Owner Name',
                                    hintStyle: TextStyle(color: Colors.black26),
                                    prefixIcon: Icon(Icons.person),
                                    prefixIconColor: Colors.black38,
                                  ),
                                  // validator: (value) {
                                  //   if (value == null ||
                                  //       value.isEmpty ||
                                  //       RegExp(r'^[0-9]').hasMatch(value)) {
                                  //     return 'Owner Name is required.';
                                  //   }
                                  //   return null;
                                  // },
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Owner Name cannot be empty";
                                    } else if (val.length < 3) {
                                      return "Please enter must 3 digit Owner Name";
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 5, left: 30, bottom: 10, right: 30),
                                child: TextFormField(
                                  controller: mobileController,
                                  cursorColor: Colors.black,
                                  keyboardType: TextInputType.number,
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
                                    hintText: 'Enter Whatsapp Number Only',
                                    hintStyle: TextStyle(color: Colors.black26),
                                    prefixIcon: Icon(Icons.phone),
                                    prefixIconColor: Colors.black38,
                                  ),
                                  // validator: (value) {
                                  //   if (value!.length < 10 ) {
                                  //     return 'Please enter 10 digit mobile number';
                                  //   }
                                  //   return  "";
                                  // },
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "mobile cannot be empty";
                                    } else if (val.length < 10) {
                                      return "Please enter 10 digit number";
                                    }
                                  },
                                  inputFormatters: <TextInputFormatter>[
                                    LengthLimitingTextInputFormatter(10),
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9{10}]'),
                                    ),
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 30, bottom: 50, right: 30),
                                child: TextFormField(
                                  controller: emailController,
                                  cursorColor: Colors.black,
                                  keyboardType: TextInputType.emailAddress,
                                  // maxLength: 10,
                                  decoration: const InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black26),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black26),
                                    ),
                                    hintText: 'Email ID',
                                    hintStyle: TextStyle(color: Colors.black26),
                                    prefixIcon: Icon(Icons.email),
                                    prefixIconColor: Colors.black38,
                                  ),

                                  validator: (value) {
                                    if (value!.isEmpty ||
                                        !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                            .hasMatch(value)) {
                                      return "Enter Correct Email Address";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                              Btn(
                                height: 45,
                                width: 200,
                                title: isLodding == true
                                    ? "Please wait..."
                                    : "Next",
                                onPress: () {
                                  // name = nameController.text;
                                  // mobile = mobileController.text;
                                  // email = emailController.text;
                                  if (_formKey.currentState!.validate()) {
                                    sendOtpRegister();
                                  } else {
                                    const snackBar = SnackBar(
                                      content: Text('all fields are required'),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  }
                                },
                              ),
                              SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 100, top: 670),
                    child: Row(
                      children: [
                        const Text(
                          "Already have an account?",
                          style: TextStyle(
                            color: Colors.black26,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'login');
                          },
                          child: const Text(
                            'Log In',
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

  bool isLodding = false;
  int? Otp;
  String? name, mobile, email;

  sendOtpRegister() async {
    setState(() {
      isLodding = true;
    });
    var headers = {
      'Cookie': 'ci_session=9f716d1e5f902c80cb9817d8d7c21bd06c994944'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse('${baseUrl}send_otp_register'));
    request.fields.addAll({
      'name': nameController.text,
      'mobile': mobileController.text,
      'email': emailController.text
    });

    print(request.fields);
    print(request.url);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);
      if (finalResult['error'] == false) {
        Otp = finalResult['data']['otp'];
        name = finalResult['data']['name'];
        mobile = finalResult['data']['mobile'];
        email = finalResult['data']['email'];
        setState(() {
          isLodding = false;
        });
        Fluttertoast.showToast(msg: "${finalResult['message']}");
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => SendOtpRegister(
                      name: name,
                      otp: Otp,
                      mobile: mobile,
                      email: email,
                    )));
      }
    } else {
      setState(() {
        isLodding = false;
      });
      print(response.reasonPhrase);
    }
  }
}
