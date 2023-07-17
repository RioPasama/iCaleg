import 'package:flutter/material.dart';
import 'package:icaleg/infrastructure/theme/theme_utils.dart';

Widget loadingDefault() {
  return Center(
      child: CircularProgressIndicator(color: colorPrimary, strokeWidth: 4));
}
