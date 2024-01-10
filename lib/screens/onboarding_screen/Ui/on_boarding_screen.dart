import 'package:book_shop/config/routs/routs_names.dart';
import 'package:book_shop/core/utils/colors.dart';
import 'package:book_shop/core/utils/common_functions.dart';
import 'package:book_shop/core/utils/extintions.dart';
import 'package:book_shop/screens/login_screen/logic/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/styles.dart';
import '../logic/onboarding_cubit.dart';
import 'widget/dots_indicator_widget.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<OnboardingCubit>(
        create: (BuildContext context) => OnboardingCubit(),
      ),
    ], child: const OnboardingScreen());
  }
}

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final onboardingCubitObject = BlocProvider.of<OnboardingCubit>(context);
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Padding(
          padding: const EdgeInsets.only(right: 28.0, left: 28.0, top: 70),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 6,
                child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: onboardingCubitObject.pageController,
                  onPageChanged: (index) {
                    onboardingCubitObject.currentIndex(index);
                  },
                  itemCount: onboardingCubitObject.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(children: [
                      Image.asset(
                        onboardingCubitObject.data[index].image.toString(),
                        width: double.infinity,
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
                    ]);
                  },
                ),
              ),
              heightSpace(28),
              BlocBuilder<OnboardingCubit, OnboardingState>(
                builder: (context, onboardingState) {
                  return BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          DotsIndicatorWidget(
                              currentIndex: onboardingCubitObject.pageIndex),
                          heightSpace(28),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  onboardingCubitObject.pageController
                                      .previousPage(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.linear);
                                },
                                child: Text('Previous',
                                    style: TextStyle(color: AppColors.primary)),
                              ),
                              onboardingCubitObject.pageIndex == 2
                                  ? TextButton(
                                      onPressed: () {
                                        context.navigateToAndReplacement(
                                            RouteName.LOGIN);
                                      },
                                      child: Text(
                                        'Login',
                                        style:
                                            TextStyle(color: AppColors.primary),
                                      ),
                                    )
                                  : TextButton(
                                      onPressed: () {
                                        onboardingCubitObject.pageController
                                            .nextPage(
                                                duration: const Duration(
                                                    milliseconds: 300),
                                                curve: Curves.linear);
                                      },
                                      child: Text('Next',
                                          style: TextStyle(
                                              color: AppColors.primary)),
                                    )
                            ],
                          ),
                        ],
                      );
                    },
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
