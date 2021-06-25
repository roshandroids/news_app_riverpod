import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:news_app_riverpod/controllers/theme_controller.dart';

import 'package:news_app_riverpod/utils/theme_palatte.dart';

extension ContextExtension on BuildContext {
  ThemePalatte get theme => useProvider(themeController.state);
}
