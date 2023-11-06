
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../AuthView/login.dart';
import '../Screen/HomeScreen.dart';

String? finalOtp;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.initState();
    getValidation();
  }

  Future getValidation()async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? obtainedOtp = sharedPreferences.getString('id');


    setState(() {
      finalOtp = obtainedOtp;


      print('user id in splash screen======================${finalOtp}');
    });


    _navigateToHome();
  }

  _navigateToHome() {
    Future.delayed(const Duration(milliseconds:  0),() {
      if (finalOtp == null || finalOtp ==  ''){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const LoginPage()));
      }else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const B2BHome()));
      }
    },);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children:[
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child:
              Image.asset('Images/Splash.png',fit: BoxFit.cover,

              ),
            ),
            const Center(
              child: Text(''
                  'B2BDIARY',
                style: TextStyle(color: Colors.white,fontSize: 28,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
