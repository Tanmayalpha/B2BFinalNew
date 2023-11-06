import 'package:flutter/material.dart';

extension colors on ColorScheme{
  static MaterialColor primary_app=const MaterialColor(
    0xff046234,
    const <int,Color>{
    50: primary,
    100: primary,
    200: primary,
    300: primary,
    400: primary,
    },
  );

  //static const Color primary=Color(0xffFD5E53);
  static const Color primary=Color(0xFF256ED7);
  static const Color secondary=Color(0xff05b050);
  static const Color black = Color(0xff000000);
  static const Color white = Color(0xffFFFFFF);
}