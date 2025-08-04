import 'package:flutter/material.dart';

class AppTextTheme {
  AppTextTheme._();

  // Main text theme
  static TextTheme get textTheme {
    return TextTheme(
      // Display styles - largest text
      displayLarge: TextStyle(
        fontFamily: 'SF-Pro-Text',
        fontWeight: FontWeight.w700,
        fontSize: 32,
        color: Colors.black,
        height: 1.2,
      ),
      displayMedium: TextStyle(
        fontFamily: 'SF-Pro-Text',
        fontWeight: FontWeight.w600,
        fontSize: 28,
        color: Colors.black,
        height: 1.2,
      ),
      displaySmall: TextStyle(
        fontFamily: 'SF-Pro-Text',
        fontWeight: FontWeight.w600,
        fontSize: 24,
        color: Colors.black,
        height: 1.25,
      ),

      // Headline styles - section headers
      headlineLarge: TextStyle(
        fontFamily: 'SF-Pro-Text',
        fontWeight: FontWeight.w600,
        fontSize: 22,
        color: Colors.black,
        height: 1.3,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'SF-Pro-Text',
        fontWeight: FontWeight.w600,
        fontSize: 20,
        color: Colors.black,
        height: 1.3,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'SF-Pro-Text',
        fontWeight: FontWeight.w500,
        fontSize: 18,
        color: Colors.black,
        height: 1.35,
      ),

      // Title styles - card titles, dialog titles
      titleLarge: TextStyle(
        fontFamily: 'SF-Pro-Text',
        fontWeight: FontWeight.w500,
        fontSize: 16,
        color: Colors.black,
        height: 1.4,
      ),
      titleMedium: TextStyle(
        fontFamily: 'SF-Pro-Text',
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: Colors.black,
        height: 1.4,
      ),
      titleSmall: TextStyle(
        fontFamily: 'SF-Pro-Text',
        fontWeight: FontWeight.w500,
        fontSize: 12,
        color: Colors.black87,
        height: 1.4,
      ),

      // Body styles - main content text
      bodyLarge: TextStyle(
        fontFamily: 'SF-Pro-Text',
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: Colors.black,
        height: 1.5,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'SF-Pro-Text',
        fontWeight: FontWeight.w400,
        fontSize: 14,
        color: Colors.black87,
        height: 1.5,
      ),
      bodySmall: TextStyle(
        fontFamily: 'SF-Pro-Text',
        fontWeight: FontWeight.w400,
        fontSize: 12,
        color: Colors.black87,
        height: 1.45,
      ),

      // Label styles - buttons, tabs, form labels
      labelLarge: TextStyle(
        fontFamily: 'SF-Pro-Text',
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: Colors.black,
        height: 1.4,
      ),
      labelMedium: TextStyle(
        fontFamily: 'SF-Pro-Text',
        fontWeight: FontWeight.w500,
        fontSize: 12,
        color: Colors.black87,
        height: 1.4,
      ),
      labelSmall: TextStyle(
        fontFamily: 'SF-Pro-Text',
        fontWeight: FontWeight.w500,
        fontSize: 10,
        color: Colors.black87,
        height: 1.4,
      ),
    );
  }
}

// Extension for custom text styles
extension CustomTextStyles on TextTheme {
  TextStyle get appBarTitle => TextStyle(
    fontFamily: 'SF-Pro-Text',
    fontWeight: FontWeight.w600,
    fontSize: 18,
    color: Colors.black,
  );

  TextStyle get buttonText => TextStyle(
    fontFamily: 'SF-Pro-Text',
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: Colors.white,
  );

  TextStyle get captionText => TextStyle(
    fontFamily: 'SF-Pro-Text',
    fontWeight: FontWeight.w400,
    fontSize: 10,
    color: Colors.black54,
    height: 1.4,
  );

  TextStyle get errorText => TextStyle(
    fontFamily: 'SF-Pro-Text',
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: Colors.red,
    height: 1.4,
  );

  TextStyle get linkText => TextStyle(
    fontFamily: 'SF-Pro-Text',
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: Colors.blue,
    height: 1.4,
    decoration: TextDecoration.underline,
  );

  TextStyle get subtitle => TextStyle(
    fontFamily: 'SF-Pro-Text',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: Colors.grey[600],
    height: 1.4,
  );
}
