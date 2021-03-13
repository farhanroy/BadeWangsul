import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  textTheme: GoogleFonts.poppinsTextTheme(),
  primaryColorDark: const Color(0xFF000D43),
  primaryColorLight: const Color(0xFF5F5B9E),
  primaryColor: const Color(0xFF31326F),
  accentColor: const Color(0xFF28527A),
  scaffoldBackgroundColor: const Color(0xFFFFFFFF),
  buttonColor: const Color(0xFF31326F),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
);