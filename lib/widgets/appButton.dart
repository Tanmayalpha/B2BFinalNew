//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../color.dart';
//
// Widget btn({VoidCallback? onTap, String? title, double? height, double? width }) {
//   return SizedBox(
//     height: height ?? 40,
//     width: width ?? 190,
//     child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: colors.primary,
//
//
//         ),
//         onPressed: onTap, child:  Text(title ?? '--',
//     style: const TextStyle(
//     fontWeight: FontWeight.bold,
//     fontSize: 16))),
//   );
// }

import 'dart:ui';
import 'package:flutter/material.dart';
import '../color.dart';

class Btn extends StatelessWidget {
  final String? title;
  final VoidCallback? onPress;
  double? height;
  double? width;
  double? fSize;
  IconData? icon;
  Color? color;
  Btn({Key? key,
    this.title, this.onPress, this.height, this.width, this.fSize, this.icon,this.color
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.bottomRight,
              colors: [
                colors.primary,
                colors.primary,
              ],
              stops: [
                0,
                1,
              ]),
          borderRadius: BorderRadius.circular(10),
          // border: Border.all(color:colors.primary)
        ),
        height: height,
        width: width,
        child: Center(
          child: Text(
            "$title",
            style:  TextStyle(
              color:colors.white,
              fontSize: fSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
