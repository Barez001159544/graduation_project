import 'package:flutter/material.dart';

class CustomTextFields extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final Color primaryColor;
  final Color textColor;
  final Color bgColor;
  final double radius;
  final int? maxLines;
  final bool readOnly;
  const CustomTextFields(this.controller, this.hint, this.primaryColor, this.textColor, this.bgColor, this.radius, this.maxLines, this.readOnly);
  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLines,
      expands: maxLines==null?true:false,
      controller: controller,
      cursorColor: primaryColor,
      readOnly: readOnly,
      textAlignVertical: maxLines==null?TextAlignVertical.top:TextAlignVertical.center,
      style: TextStyle(
        color: primaryColor,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        hintText: "$hint",
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 14,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(radius),
        ),
        filled: true,
        fillColor: bgColor,
      ),
    );
  }
}