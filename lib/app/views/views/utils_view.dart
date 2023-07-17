import 'package:flutter/material.dart';

TextFormField textFromFiled({
  TextEditingController? controller,
  Widget? prefixIcon,
  String? hintText,
  String? labelText,
  int? maxLines = 1,
  TextInputType? keyboardType,
  TextInputAction textInputAction = TextInputAction.next,
  bool obscureText = false,
  Widget? suffixIcon,
  String? Function(String?)? validator,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    obscureText: obscureText,
    textInputAction: textInputAction,
    maxLines: maxLines,
    textCapitalization: TextCapitalization.none,
    decoration: InputDecoration(
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      hintText: hintText,
      labelText: labelText,
    ),
    validator: validator,
  );
}
