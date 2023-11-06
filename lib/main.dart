
// import 'package:anoop/Screens/new.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'AuthView/login.dart';
import 'Splash/SplashScreen.dart';
import 'AuthView/register.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,

  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'splash',
      routes: {
       // 'new' : (context) => New(),
        'splash' : (context) => const SplashScreen(),
        'login' : (context) => const LoginPage(),
        'register' : (context) => const RegisterPage(),
       // 'detail' : (context) => DetailPage(),
      },
    );
  }
}
