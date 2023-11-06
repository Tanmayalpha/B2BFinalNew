import 'package:flutter/material.dart';

import '../color.dart';

class Custom_Button extends StatelessWidget {
  const Custom_Button({Key? key,required this.text,
    this.icon,
    required this.onPressed,}) : super(key: key);

  final String text;
  final IconData? icon;
  final VoidCallback onPressed;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 40,
        width: 100,
        decoration: BoxDecoration(
            color: colors.primary,
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: Row(
          children: [
            SizedBox(width: 7,),
            Icon(Icons.upload_sharp,color: Colors.white,),
            Text(text,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),)
          ],
        ),
      ),
    );
  }
}