import 'package:book_shop/core/utils/extintions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/common_functions.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/widget/app_buttons.dart';

class ContentCard extends StatelessWidget {
  const ContentCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color:Theme.of(context).brightness==Brightness.dark?AppColors.lightBlue: AppColors.lighterPrimary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 30.0.h, left: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Special Offer',
                    style: TextStyles.font24BlackBold(context).copyWith(fontSize: 23),
                  ),
                  Text(
                    'Discount 25%',
                    style: TextStyles.font15BlackMedium(context),
                  ),
                  heightSpace(16),
                  primaryButton(
                    title: 'Order Now',
                    borderRadius: 40,
                    verticalHeight: 5,
                  ).onTap(() {}),
                ],
              ),
            ),
          ),
          Expanded(
              child: Image.asset(
            'assets/images/swiper_image.png',
            fit: BoxFit.fitHeight,
          )),
        ],
      ),
    );
  }
}
