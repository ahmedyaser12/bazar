import 'package:flutter/material.dart';

import 'colors.dart';

class MyAppThemes {
  static final lightTheme = ThemeData(
    primaryColor: AppColors.lightBlue,
    brightness: Brightness.light,
  );

  static final darkTheme = ThemeData(
    primaryColor: AppColors.darkBlue,
    brightness: Brightness.dark,
  );
}
