import 'package:flutter/material.dart';

class AppColors {
  static const LinearGradient mainGradient = LinearGradient(
    colors: [
      Color(0xFF0D1B2A), // deep blue
      Color(0xFF1B263B), // navy
      Color(0xFF144552), // teal hint
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Light version
  static const LinearGradient mainGradientLight = LinearGradient(
    colors: [
      Color(0xFFE0F0FF), // very light blue
      Color(0xFFBFDFFF), // soft sky blue
      Color(0xFF99D6FF), // pastel teal hint
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
