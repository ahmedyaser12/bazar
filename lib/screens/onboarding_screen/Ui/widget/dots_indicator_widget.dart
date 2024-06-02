import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/colors.dart';

class DotsIndicatorWidget extends StatelessWidget {
  final int? currentIndex;

  const DotsIndicatorWidget({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return DotsIndicator(
      dotsCount: 3,
      position: currentIndex!,
      decorator: DotsDecorator(
        spacing: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
        size: Size(6.w, 6.h),
        activeSize: Size(25.0.w, 6.0.h),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        color: AppColors.greyColor,
        activeColor: AppColors.primary,
      ),
    );
  }
}
