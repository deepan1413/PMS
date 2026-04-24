import 'package:flutter/material.dart';

class MyTextFiled extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final bool isObscure;
  final Icon? prefixIcon;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;

  const MyTextFiled({
    super.key ,
    required this.labelText,
    required this.hintText,
    required this.controller,
    this.isObscure = false,
     this.prefixIcon,
     this.keyboardType,
     this.suffixIcon
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isObscure,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      keyboardType: keyboardType,
    );
  }
}
