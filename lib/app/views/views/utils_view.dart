import 'package:flutter/material.dart';

TextFormField textFromFiled({
  TextEditingController? controller,
  Icon? prefixIcon,
  String? hintText,
  TextInputType? keyboardType,
  TextInputAction textInputAction = TextInputAction.next,
  bool obscureText = false,
  Widget? suffixIcon,
  Function(String?)? validator,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    obscureText: obscureText,
    textInputAction: textInputAction,
    decoration: InputDecoration(
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      hintText: hintText,
      fillColor: Colors.white70,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(),
      ),
    ),
    validator: (value) => (validator != null) ? validator(value) : null,
  );
}
