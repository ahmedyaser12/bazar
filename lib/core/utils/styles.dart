import 'package:flutter/material.dart';
import 'colors.dart';

class TextStyles {
  static TextStyle font24BlackBold(BuildContext context) {
    return TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).brightness == Brightness.light ? AppColors.blackColor : AppColors.whiteColor,
    );
  }

  static TextStyle font16grey(BuildContext context) {
    return TextStyle(
      fontSize: 16,
      color: Theme.of(context).brightness == Brightness.light ? AppColors.greyColor : AppColors.darkGreyColor,
    );
  }

  static TextStyle font13grey500weight = const TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: Color.fromRGBO(255, 255, 255, 0.6),
  );

  static TextStyle font15White500weight = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: AppColors.whiteColor,
  );

  static TextStyle font15BlackMedium(BuildContext context) {
    return TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: Theme.of(context).brightness == Brightness.light ? AppColors.blackColor : AppColors.whiteColor,
    );
  }

  static TextStyle font14PrimarySemi = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
  );

  static TextStyle font14BlackSemi(BuildContext context) {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: Theme.of(context).brightness == Brightness.light ? AppColors.blackColor : AppColors.whiteColor,
    );
  }

  static TextStyle font16PrimarySemi = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
  );

  static TextStyle font18BlackBold(BuildContext context) {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).brightness == Brightness.light ? AppColors.blackColor : AppColors.whiteColor,
    );
  }

  static TextStyle font14RedBold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    color: AppColors.redColor,
  );
}
