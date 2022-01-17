import 'package:flutter/material.dart';

class CostomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labText;
  final TextInputType keyboardType;
  CostomTextField(
      {required this.keyboardType,
      required this.labText,
      required this.controller});
  @override
  Widget build(BuildContext context) {
    return TextField(
     cursorColor: Color(0xFFFF7643),
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        labelText: labText,
          labelStyle: TextStyle(color:Colors.black),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color:Color(0xFFFF7643))),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFFF7643)))
      ),
    );
  }
}
