import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:news_app_riverpod/controllers/theme_controller.dart';
import 'package:news_app_riverpod/utils/core_palatte.dart';

class AppThemes {
  AppThemes._();
  static final corePalatte = CorePalatte(
    primaryColor: Color(0xFFD01118),
    secondaryColor: Color(0xFF000000),
    primaryColorAccent: Color(0xFFEFE6FF),
    notificationIconColor: Color(0xFFB7C1D3),
    notificationbackgroundColor: Color(0xFFFD655C),
    notificationSennColor: Color(0xFF212121),
    iconColor: Color(0xFFCAD1DE),
    greyFontColor: Color(0xFF8D92A3),
    textBlueColor: Color(0xFF6478D3),
    lightWhite: Color(0xFFF8F8F8),
    backgroundBlueColor: Color(0xFFF6F9FF),
    getStartedBackGroundColor: Color(0xFFF6F9FF),
    greyColor: Color(0xFF9C9C9C),
    lightGreyColor: Color(0xFFF0F0F0),
    greenColor: Color(0xFF3CC13C),
    seaGreenColor: Color(0xFF15CDA8),
    outOfStockColor: Color(0xFFFD655C),
    splashColor: Color(0x33D01118),
    whiteTransparentColor: Color(0x80FFFFFF),
    white: Color(0xFFFFFFFF),
    progressBarColor: Color(0xFFECEFF4),
    black: Color(0xFF000000),
    gray: Color(0xFF333333),
    pink: Color(0xFFEF4B5F),
    gray30: Color.fromRGBO(0, 0, 0, 0.3),
    lightwhite: Color(0xFFF1F3F8),
    yellow: Color(0xFFEFE142),
  );
  static final lightThemeData = ThemeData(
    brightness: Brightness.light,
    backgroundColor: const Color(0xffFFFFFF),
    primaryColor: const Color(0xffD01118),
    appBarTheme: AppBarTheme(
      color: const Color(0xFFF6F9FF),
    ),
  );

  static final darkThemeData = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: const Color(0xFF0A1A1E),
    // primaryColor: const Color(0xffD01118),
    appBarTheme: AppBarTheme(
      color: const Color(0xFF314045),
    ),
  );
}
