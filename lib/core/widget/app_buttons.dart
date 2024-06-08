import 'package:book_shop/core/utils/colors.dart';
import 'package:flutter/material.dart';

Widget primaryButton(
    {required String title,
    required double borderRadius,
    double verticalHeight = 20}) {
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.symmetric(vertical: verticalHeight),
    decoration: BoxDecoration(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(borderRadius),
    ),
    child: FittedBox(
      child: Text(
        title,
        style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: 16,
            fontWeight: FontWeight.bold),
      ),
    ),
  );
}

Widget secondaryButton(BuildContext context, String title, {String? image}) {
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.symmetric(vertical: 16),
    decoration: BoxDecoration(
      color: Theme.of(context).brightness == Brightness.dark
          ? AppColors.lightBlue
          : AppColors.secondary,
      borderRadius: BorderRadius.circular(30),
    ),
    child: FittedBox(
      child: Text(
        title,
        style: TextStyle(
          color: AppColors.primary,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
