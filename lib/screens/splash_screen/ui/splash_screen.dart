import 'package:book_shop/core/utils/colors.dart';
import 'package:book_shop/core/utils/extintions.dart';
import 'package:flutter/material.dart';

import '../../../config/routs/routs_names.dart';
import '../../../core/helper/cache_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 2),
      () => CacheHelper().getData(key: 'login') == true
          ? context.navigateToAndReplacement(RouteName.NAV)
          : context.navigateToAndReplacement(RouteName.ONBOARDING),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset('assets/images/img.png'),
          )
        ],
      ),
    );
  }
}
