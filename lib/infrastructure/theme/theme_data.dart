import 'package:flutter/material.dart';
import 'package:icaleg/infrastructure/theme/theme_utils.dart';

ThemeData themeData() {
  return ThemeData(
    textTheme: textTheme,
    colorScheme: ThemeData().colorScheme.copyWith(primary: colorPrimary),
    dialogBackgroundColor: Colors.white.withOpacity(0.88),
    inputDecorationTheme: const InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1,
        ),
      ),
    ),
    dialogTheme: const DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
    ),
  );
}
