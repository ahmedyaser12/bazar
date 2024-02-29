import 'package:book_shop/core/chase_helper/cache_helper.dart';
import 'package:book_shop/core/utils/colors.dart';
import 'package:book_shop/core/utils/extintions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../config/routs/routs_names.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    Future.delayed(
      const Duration(seconds: 2),
      () => CacheHelper().getData(key: 'login') != false
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
