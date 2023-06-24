import 'package:flutter/material.dart';
import 'package:icaleg/infrastructure/theme/theme_utils.dart';

ThemeData themeData() {
  return ThemeData(
    textTheme: textTheme,
    colorScheme: ThemeData().colorScheme.copyWith(primary: colorPrimary),
    dialogBackgroundColor: Colors.white.withOpacity(0.88),
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      hintStyle: TextStyle(color: colorTextGray),
      border: OutlineInputBorder(
        borderRadius: borderRadiusTheme,
        borderSide: const BorderSide(),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: borderRadiusTheme,
        borderSide: const BorderSide(),
      ),
    ),
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(borderRadius: borderRadiusTheme),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: borderRadiusTheme,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
        side: BorderSide(color: colorPrimary),
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: borderRadiusTheme,
        ),
      ),
    ),
  );
}
