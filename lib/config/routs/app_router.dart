import 'package:book_shop/config/routs/routs_names.dart';
import 'package:book_shop/screens/card_screen/ui/card_screen.dart';
import 'package:book_shop/screens/favorite_screen/ui/favourite_screen.dart';
import 'package:book_shop/screens/login_screen/logic/login_cubit.dart';
import 'package:book_shop/screens/login_screen/ui/login_screen.dart';
import 'package:book_shop/screens/onboarding_screen/logic/onboarding_cubit.dart';
import 'package:book_shop/screens/profile_screen/data/user_model.dart';
import 'package:book_shop/screens/profile_screen/logic/profile_screen_cubit.dart';
import 'package:book_shop/screens/search_screen/logic/search_screen_cubit.dart';
import 'package:book_shop/screens/search_screen/ui/search_sceen.dart';
import 'package:book_shop/screens/sign_up_screen/ui/sign_up_screen.dart';
import 'package:book_shop/screens/splash_screen/ui/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../screens/bottom_nav_bar/bottom_nav_bar.dart';
import '../../screens/onboarding_screen/Ui/on_boarding_screen.dart';
import '../../screens/profile_screen/ui/acount_screen.dart';
import '../../screens/sign_up_screen/logic/sign_up_cubit.dart';
import '../../services/services_locator.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.LOGIN:
        return MaterialPageRoute(
          builder: ((context) => BlocProvider(
              create: (_) => locator<LoginCubit>(),
              child: const LoginScreen())),
        );
      case RouteName.NAV:
        return MaterialPageRoute(
          builder: ((context) => const BottomNavBar()),
        );
      case RouteName.SPLASH:
        return MaterialPageRoute(
          builder: ((context) => const SplashScreen()),
        );
      case RouteName.ONBOARDING:
        return MaterialPageRoute(
          builder: ((context) => BlocProvider.value(
                value: locator<OnboardingCubit>(),
                child: const OnboardingScreen(),
              )),
        );
      case RouteName.FAVOURITE:
        return MaterialPageRoute(
          builder: ((context) => const FavouriteScreen()),
        );
      case RouteName.CART:
        return MaterialPageRoute(
          builder: ((context) => const CartScreen()),
        );
      case RouteName.MYACCOUNT:
        UserModel? userDetails = settings.arguments as UserModel?;
        return MaterialPageRoute(
          builder: ((context) => BlocProvider.value(
                value: locator<ProfileScreenCubit>(),
                child: MyAccountScreen(
                  userModel: userDetails!,
                ),
              )),
        );
      case RouteName.SEARCH:
        return MaterialPageRoute(
          builder: ((context) => BlocProvider.value(
                value: locator<SearchCubit>(),
                child: const SearchScreen(),
              )),
        );
      case RouteName.SIGNUP:
        return MaterialPageRoute(
            builder: (context) => BlocProvider.value(
                value: locator<SignUpCubit>(), child: const SignUpScreen()));
      default:
        return notFound();
    }
  }

  static Route<dynamic> notFound() {
    return MaterialPageRoute(
      builder: ((context) => const Scaffold(
            body: Center(
              child: Text('Not Fount'),
            ),
          )),
    );
  }
}
