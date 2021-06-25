import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:news_app_riverpod/controllers/theme_controller.dart';

import 'package:news_app_riverpod/utils/context_extension.dart';

class TestScreen extends StatefulHookWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.background,
      appBar: AppBar(),
      body: Center(
        child: DarkModeSwitch(),
      ),
    );
  }
}

class DarkModeSwitch extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final themePalatte = context.read(themeController.state);
    return Switch(
      value: themePalatte.isDarkTheme,
      onChanged: (enabled) {
        context.read(themeController).changeTheme(themePalatte.isDarkTheme);
      },
    );
  }
}
