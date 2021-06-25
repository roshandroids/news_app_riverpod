import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:news_app_riverpod/failures/failure.dart';
import 'package:news_app_riverpod/utils/theme_palatte.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeRepository = Provider<IThemeRepository>((ref) {
  return ThemeRepository();
});

abstract class IThemeRepository {
  Future<Either<ThemePalatte, Failure>> fetchTheme();

  Future<Either<ThemePalatte, Failure>> changeTheme({
    required bool isDarkTheme,
  });
}

class ThemeRepository implements IThemeRepository {
  @override
  Future<Either<ThemePalatte, Failure>> fetchTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      final isDarkTheme = await prefs.getBool("isDarkTheme");
      return Left(isDarkTheme != null && isDarkTheme
          ? ThemePalatte.darkThemePalatte
          : ThemePalatte.lightThemePalatte);
    } catch (e) {
      return Right(Failure.fromException(e));
    }
  }

  @override
  Future<Either<ThemePalatte, Failure>> changeTheme({
    required bool isDarkTheme,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await prefs.setBool("isDarkTheme", !isDarkTheme);
      return Left(
        isDarkTheme
            ? ThemePalatte.lightThemePalatte
            : ThemePalatte.darkThemePalatte,
      );
    } catch (e) {
      return Right(Failure.fromException(e));
    }
  }
}
