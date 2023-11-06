
import 'package:flutter/material.dart';
class CustomCol extends StatelessWidget {
  CustomCol({Key? key,required this.text,required this.text2,required this.hinttext}) : super(key: key);
  final String text;
  final String text2;
  final String hinttext;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
        Text(text2,style: TextStyle(fontSize: 16),),
        Container(
          width: MediaQuery.of(context).size.width/4,
          child: TextFormField(
            decoration: InputDecoration(
              hintText: hinttext,
            ),
            validator: (value){
              if(value==null||value.isEmpty){
                return "field is required";
              }
              return null;
            },
          ),
        )

      ],
    );
  }
}
