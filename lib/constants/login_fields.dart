import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginFields extends StatelessWidget {
  final TextEditingController controller;
  final bool isShown;
  final String hint;
  final Color primaryColor;
  final Color textColor;
  const LoginFields(this.controller, this.isShown, this.hint, this.primaryColor, this.textColor);
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isShown,
      cursorColor: primaryColor,
      textAlignVertical: TextAlignVertical.bottom,
      inputFormatters: hint=="### ####"?<TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        FilteringTextInputFormatter.digitsOnly
      ]:<TextInputFormatter>[],
      keyboardType: hint=="### ####"?TextInputType.number:TextInputType.emailAddress,
      style: TextStyle(
        color: primaryColor,
        fontSize: hint=="### ####"?24:16,
      ),
      decoration: InputDecoration(
        hintText: "$hint",
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: hint=="### ####"?24:14,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 1, color: Colors.grey, style: BorderStyle.solid,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 1, color: Color(0xff155E7D), style: BorderStyle.solid,
          ),
        ),
      ),
    );
  }
}