import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gtrack_mobile_app/global/common/colors/app_colors.dart';

class Themes {
  static const MaterialColor primarySwatch = MaterialColor(
    0xFF0D117F,
    <int, Color>{
      50: Color(0xFFE2E4F7),
      100: Color(0xFFB6BAE8),
      200: Color(0xFF898FD8),
      300: Color(0xFF5D64C8),
      400: Color(0xFF3A43BB),
      500: Color(0xFF0D117F),
      600: Color(0xFF0C0F6D),
      700: Color(0xFF0A0D5A),
      800: Color(0xFF080B47),
      900: Color(0xFF060935),
    },
  );

  static const double _appBarIconSize = 24.0;
  static const TextStyle _appBarTitleTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 16, // Adjust this value to make the text smaller
    fontWeight: FontWeight.w600,
  );

  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.primary,
      primarySwatch: primarySwatch,
      brightness: Brightness.light,
      elevatedButtonTheme:
          _elevatedButtonTheme(AppColors.white, AppColors.primary),
      buttonTheme: _buttonTheme(AppColors.primary),
      appBarTheme: _appBarTheme(AppColors.primary, Brightness.light),
      textTheme: _textTheme(),
      textButtonTheme: _textButtonTheme(AppColors.primary),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      primaryColor: AppColors.primary,
      primarySwatch: primarySwatch,
      brightness: Brightness.dark,
      elevatedButtonTheme:
          _elevatedButtonTheme(Colors.white, AppColors.primary),
      buttonTheme: _buttonTheme(AppColors.primary),
      appBarTheme: _appBarTheme(AppColors.primary, Brightness.dark),
      textTheme: _textTheme(),
      textButtonTheme: _textButtonTheme(Colors.white),
    );
  }

  static ElevatedButtonThemeData _elevatedButtonTheme(
      Color foregroundColor, Color backgroundColor) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
        textStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w700,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }

  static ButtonThemeData _buttonTheme(Color buttonColor) {
    return ButtonThemeData(
      buttonColor: buttonColor,
      textTheme: ButtonTextTheme.primary,
      padding: const EdgeInsets.all(5),
    );
  }

  static AppBarTheme _appBarTheme(Color color, Brightness statusBarBrightness) {
    return AppBarTheme(
      color: color,
      elevation: 0,
      centerTitle: true,
      iconTheme: const IconThemeData(
        color: Colors.white,
        size: _appBarIconSize,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: statusBarBrightness,
      ),
      toolbarTextStyle: _appBarTitleTextStyle,
      titleTextStyle: _appBarTitleTextStyle,
    );
  }

  static TextTheme _textTheme() {
    return const TextTheme(
      displayLarge: TextStyle(
        fontSize: 72.0,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        fontSize: 20.0,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w700,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.0,
        fontFamily: 'Inter',
      ),
      bodySmall: TextStyle(
        fontSize: 12.0,
        fontFamily: 'Inter',
      ),
    );
  }

  static TextButtonThemeData _textButtonTheme(Color foregroundColor) {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: foregroundColor,
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
