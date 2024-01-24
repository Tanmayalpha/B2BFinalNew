
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  CustomTextFormField({
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // maxLines: 4,
      cursorHeight: 25,
      controller: controller,
      decoration: InputDecoration(
        // border: OutlineInputBorder(),
        // filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 14
          ),

      ),
      validator:(value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $hintText .';
        }
        return null;
      },
    );
  }
}