import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/common_functions.dart';

class SocialLogin extends StatelessWidget {
  final String socialIcon;
  final String title;

  const SocialLogin({super.key, required this.socialIcon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          border: Border.all(width: 1, color: AppColors.gery50)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(socialIcon),
          widthSpace(8),
          Text(title),
        ],
      ),
    );
  }
}
