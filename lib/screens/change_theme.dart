import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:news_app_riverpod/utils/context_extension.dart';
import 'package:news_app_riverpod/controllers/theme_controller.dart';
import 'package:news_app_riverpod/screens/test_screen.dart';

class MyHomePage extends StatefulHookWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.background,
      appBar: AppBar(
        elevation: 2.0,
        actions: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Light Mode',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                DarkModeSwitch(),
                Text(
                  'Dark Mode',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          ),
        ],
      ),
      body: ListView.separated(
        itemBuilder: (_, item) {
          return ListTile(
            leading: FlutterLogo(),
            title: Text(
              "Item no. $item",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            // tileColor: context.theme.surface,
            trailing: Icon(
              Icons.delete,
              color: context.theme.corePalatte.primaryColor,
            ),
          );
        },
        separatorBuilder: (context, item) {
          return Divider();
        },
        itemCount: 20,
      ),
    );
  }
}
