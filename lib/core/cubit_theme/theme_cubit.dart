import 'package:book_shop/core/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(themeData: MyAppThemes.lightTheme));
  ThemeData? theme;

  void toggleTheme() {
    final isLightTheme = state.themeData == MyAppThemes.lightTheme;
    theme = isLightTheme ? MyAppThemes.darkTheme : MyAppThemes.lightTheme;
    emit(ThemeState(
        themeData:
            isLightTheme ? MyAppThemes.darkTheme : MyAppThemes.lightTheme));
  }
}
