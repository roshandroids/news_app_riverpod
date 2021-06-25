import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:news_app_riverpod/repositories/theme_repository.dart';
import 'package:news_app_riverpod/utils/theme_palatte.dart';

final themeController =
    StateNotifierProvider((ref) => ThemeController(ref.read)..fetchTheme());

class ThemeController extends StateNotifier<ThemePalatte> {
  ThemeController(this._read) : super(ThemePalatte.lightThemePalatte);
  final Reader _read;

  IThemeRepository get _themeRepo => _read(themeRepository);
  Future<void> fetchTheme() async {
    try {
      final theme = await _themeRepo.fetchTheme();

      state = theme.fold(
        (success) => success,
        (failure) => ThemePalatte.lightThemePalatte,
      );
    } catch (e) {
      state = ThemePalatte.lightThemePalatte;
    }
  }

  Future<void> changeTheme(bool isDarkTheme) async {
    final theme = await _themeRepo.changeTheme(isDarkTheme: isDarkTheme);
    try {
      state = theme.fold(
        (success) => success,
        (failure) => ThemePalatte.lightThemePalatte,
      );
    } catch (e) {
      state = ThemePalatte.lightThemePalatte;
    }
  }
}
