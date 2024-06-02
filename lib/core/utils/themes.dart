import 'package:flutter/material.dart';

import 'colors.dart';

class MyAppThemes {
  static final lightTheme = ThemeData(

    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.whiteColor,
    appBarTheme: AppBarTheme(
      actionsIconTheme: IconThemeData(
        color: AppColors.whiteColor,
      ),
      iconTheme: IconThemeData(
        color: AppColors.blackColor,
      ),
      backgroundColor: AppColors.whiteColor,
    ),
    cardTheme: CardTheme(color: AppColors.whiteColor),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.whiteColor,
    ),
    dividerColor: AppColors.greyColor,
    dividerTheme: DividerThemeData(color: AppColors.greyColor),
    useMaterial3: true,
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          error: Colors.red,
          onError: Colors.red,
          brightness: Brightness.light,
        )
        .copyWith(surface: AppColors.whiteColor),
  );

  static final darkTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.darkBlue,
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(color: AppColors.whiteColor),
      actionsIconTheme: IconThemeData(
        color: AppColors.whiteColor,
      ),
      iconTheme: IconThemeData(
        color: AppColors.whiteColor,
      ),
      backgroundColor: AppColors.darkBlue,
    ),
    cardTheme: CardTheme(
      color: AppColors.darkCardColor,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: 10,
      backgroundColor: AppColors.darkBlue,
    ),
    dividerColor: AppColors.darkGreyColor,
    dividerTheme: DividerThemeData(color: AppColors.darkGreyColor),
    useMaterial3: true,
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          error: Colors.red,
          onError: Colors.red,
          brightness: Brightness.dark,
        )
        .copyWith(surface: AppColors.darkBlue),
  );
}
