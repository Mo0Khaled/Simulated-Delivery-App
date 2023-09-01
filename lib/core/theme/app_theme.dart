import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFFFBAF02);
  static const Color accentColor = Color(0xFF29142B);
  static const Color deliveryPointColor = Color(0xFF2CC2DB);


  static final theme = ThemeData(
    primaryColor: primaryColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      titleTextStyle: TextStyle(
        color: AppTheme.primaryColor,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      centerTitle: false,
    ),
    platform: TargetPlatform.iOS,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: accentColor,
      primary: primaryColor,
    ),
  );

  AppTheme._();
}
