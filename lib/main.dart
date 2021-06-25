import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:news_app_riverpod/screens/change_theme.dart';
import 'package:news_app_riverpod/screens/news_home.dart';
import 'package:news_app_riverpod/utils/app_themes.dart';
import 'package:news_app_riverpod/utils/context_extension.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends HookWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: context.theme.themeMode,
      theme: ThemeData(
        brightness: context.theme.brightness,
        appBarTheme: AppBarTheme(
          color: context.theme.surface,
        ),
        textTheme: TextTheme(
          headline1: TextStyle(
              color: context.theme.textColor,
              fontSize: 30,
              fontFamily: "WorkSans",
              fontWeight: FontWeight.w700),
          headline2: TextStyle(
              color: context.theme.textColor,
              fontSize: 24,
              fontFamily: "WorkSans",
              fontWeight: FontWeight.w700),
          headline3: TextStyle(
              color: context.theme.textColor,
              fontSize: 22,
              fontFamily: "WorkSans",
              fontWeight: FontWeight.w700),
          headline4: TextStyle(
              color: context.theme.textColor,
              fontSize: 20,
              fontWeight: FontWeight.w700),
          headline5: TextStyle(
              color: context.theme.textColor,
              fontSize: 16,
              fontFamily: "WorkSans",
              fontWeight: FontWeight.w700),
          headline6: TextStyle(
              color: context.theme.textColor,
              fontSize: 16,
              fontFamily: "WorkSans",
              fontWeight: FontWeight.w700),
          subtitle1: TextStyle(
              color: context.theme.textColor,
              fontSize: 16,
              fontFamily: "WorkSans",
              fontWeight: FontWeight.w500),
          subtitle2: TextStyle(
              color: context.theme.surface,
              fontFamily: "WorkSans",
              fontSize: 14,
              fontWeight: FontWeight.w500),
          bodyText1: TextStyle(
              color: context.theme.textColor,
              fontFamily: "WorkSans",
              fontSize: 12,
              fontWeight: FontWeight.w500),
          bodyText2: TextStyle(
              color: context.theme.textColor,
              fontFamily: "WorkSans",
              fontSize: 10,
              fontWeight: FontWeight.w500),
          button: TextStyle(
              color: context.theme.textColor,
              fontWeight: FontWeight.w700,
              fontFamily: "WorkSans",
              fontSize: 14),
          caption: TextStyle(color: context.theme.textColor),
          overline: TextStyle(color: context.theme.textColor),
        ),
      ),
      home: NewsHome(),
    );
  }
}
