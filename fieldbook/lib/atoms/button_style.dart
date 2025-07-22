import 'package:flutter/material.dart';

final ElevatedButtonThemeData inputButtonTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFFE7E8E8),
    foregroundColor: Colors.black,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    elevation: 2,
    textStyle: const TextStyle(fontSize: 22),
  ),
);
