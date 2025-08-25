import 'package:flutter/material.dart';

/// Define the Theme data for the application
class AppTheme {

  static ThemeData get theme {
    return ThemeData.dark().copyWith(

      scaffoldBackgroundColor: Colors.transparent,

      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.white,
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(60),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

}

/// Define the color pallet used by the application
class AppColors {
  static const gradient = LinearGradient(
    colors: [Color(0xff1e3a8a), Color(0xff4c1d95), Color(0xff312e81)],
    begin: Alignment.topLeft, end: Alignment.bottomRight,
  );

  static const primary = Color(0xff4927f5);
  static const accent = Color(0xff9c27b0);
  static const accentAlt = Color(0xff4caf50);
  static const accentOpt = Color(0xff448aff);

  static const textPrimary = Color(0xffffffff);
  static const textSecondary = Color(0xff90caf9);

}

/// Define the text styles used by the application
class AppText {
  static const heading = TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textPrimary);
  static const subheading = TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary);
  static const important = TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.textPrimary);
  static const body = TextStyle(fontSize: 16, color: AppColors.textPrimary);
  static const caption = TextStyle(fontSize: 16, fontStyle: FontStyle.italic ,color: AppColors.accentOpt);
  static const captionAlt = TextStyle(fontSize: 16, fontStyle: FontStyle.italic ,color: AppColors.accentAlt);
  static const small = TextStyle(color: AppColors.textSecondary, fontSize: 12);
}
