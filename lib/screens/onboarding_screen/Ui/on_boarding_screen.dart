import 'package:book_shop/config/routs/routs_names.dart';
import 'package:book_shop/core/utils/colors.dart';
import 'package:book_shop/core/utils/common_functions.dart';
import 'package:book_shop/core/utils/extintions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/styles.dart';
import '../logic/onboarding_cubit.dart';
import 'widget/dots_indicator_widget.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final onboardingCubitObject = BlocProvider.of<OnboardingCubit>(context);
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Padding(
          padding: EdgeInsets.only(right: 28.0.w, left: 28.0.w, top: 70.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: onboardingCubitObject.pageController,
                  onPageChanged: (index) {
                    onboardingCubitObject.currentIndex(index);
                  },
                  itemCount: onboardingCubitObject.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SingleChildScrollView(
                      child: Column(children: [
                        Image.asset(
                          onboardingCubitObject.data[index].image.toString(),
                          fit: BoxFit.fill,
                          height: 200,
                        ),
                        Text(
                          onboardingCubitObject.data[index].title.toString(),
                          style: TextStyles.font24BlackBold,
                          textAlign: TextAlign.center,
                        ),
                        heightSpace(12),
                        Text(
                          onboardingCubitObject.data[index].subTitle.toString(),
                          style: TextStyles.font16grey,
                          textAlign: TextAlign.center,
                        ),
                      ]),
                    );
                  },
                ),
              ),
              heightSpace(28),
              BlocBuilder<OnboardingCubit, OnboardingState>(
                builder: (context, onboardingState) {
                  return Column(
                    children: [
                      DotsIndicatorWidget(
                          currentIndex: onboardingCubitObject.pageIndex),
                      heightSpace(28),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          onboardingCubitObject.pageIndex != 0
                              ? TextButton(
                                  onPressed: () {
                                    onboardingCubitObject.pageController
                                        .previousPage(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            curve: Curves.linear);
                                  },
                                  child: Text('Previous',
                                      style:
                                          TextStyle(color: AppColors.primary)),
                                )
                              : Container(),
                          TextButton(
                            onPressed: () {
                              onboardingCubitObject.pageIndex == 2
                                  ? context
                                      .navigateToAndReplacement(RouteName.LOGIN)
                                  : onboardingCubitObject.pageController
                                      .nextPage(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.linear);
                            },
                            child: Text(
                              onboardingCubitObject.pageIndex == 2
                                  ? 'Login'
                                  : 'Next',
                              style: TextStyle(color: AppColors.primary),
                            ),
                          )
                        ],
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
