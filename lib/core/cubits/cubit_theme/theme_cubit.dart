import 'package:book_shop/core/helper/cache_helper.dart';
import 'package:book_shop/core/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(themeData: _getInitialTheme()));
  static ThemeData _getInitialTheme() {
    print(CacheHelper().getData(key: 'isDarkTheme'));
    final isDarkTheme = CacheHelper().getData(key: 'isDarkTheme') ?? false;
    return isDarkTheme ? MyAppThemes.darkTheme : MyAppThemes.lightTheme;
  }
  void toggleTheme() async{
    final isLightTheme = state.themeData == MyAppThemes.lightTheme;
    final newTheme = isLightTheme ? MyAppThemes.darkTheme : MyAppThemes.lightTheme;
    await CacheHelper().saveData(key: 'isDarkTheme', value: isLightTheme);
    print(CacheHelper().getData(key: 'isDarkTheme'));
    emit(ThemeState(themeData: newTheme));
  }
}
