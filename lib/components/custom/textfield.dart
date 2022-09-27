import 'dart:html';

import 'package:flutter/material.dart';

class Textfield extends StatelessWidget {
  final String hintText;
  final TextStyle hintStyle;
  final Icon icon;
  final void Function(String)? onChanged;

  final TextEditingController controller;
  const Textfield(
      {required this.hintStyle,
      required this.hintText,
      required this.icon,
      required this.controller,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: TextFormField(
        onChanged: onChanged,
        controller: controller,
        decoration: InputDecoration(
          fillColor: Color(0xffFFFFFF),
          filled: true,
          hintText: hintText,
          hintStyle: hintStyle,
          suffixIcon: icon,
          contentPadding: EdgeInsets.only(top: 10, bottom: 10, left: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: BorderSide(
              color: Color(0xffDEDEDF),
            ),
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffEBEBEC))),
          //  focusedBorder: OutlineInputBorder(borderSide: )
        ),
      ),
    );
  }
}
