import 'package:book_shop/config/routs/routs_names.dart';
import 'package:book_shop/screens/cart_screen/ui/card_screen.dart';
import 'package:book_shop/screens/favorite_screen/ui/favourite_screen.dart';
import 'package:book_shop/screens/login_screen/logic/login_cubit.dart';
import 'package:book_shop/screens/login_screen/ui/login_screen.dart';
import 'package:book_shop/screens/map_screen/map_screen.dart';
import 'package:book_shop/screens/onboarding_screen/logic/onboarding_cubit.dart';
import 'package:book_shop/screens/profile_screen/data/user_model.dart';
import 'package:book_shop/screens/profile_screen/logic/profile_screen_cubit.dart';
import 'package:book_shop/screens/search_screen/logic/search_screen_cubit.dart';
import 'package:book_shop/screens/search_screen/ui/search_sceen.dart';
import 'package:book_shop/screens/sign_up_screen/ui/sign_up_screen.dart';
import 'package:book_shop/screens/status_order_screen/logic/status_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../screens/bottom_nav_bar/bottom_nav_bar.dart';
import '../../screens/notification_screen/ui/notification_screen.dart';
import '../../screens/onboarding_screen/Ui/on_boarding_screen.dart';
import '../../screens/profile_screen/ui/acount_screen.dart';
import '../../screens/sign_up_screen/logic/sign_up_cubit.dart';
import '../../screens/status_order_screen/ui/status_order_screen.dart';
import '../../services/services_locator.dart';

//
class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
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
      case RouteName.MAP:
        return MaterialPageRoute(
          builder: ((context) => const MapScreen()),
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
      case RouteName.STATUSORDER:
        return MaterialPageRoute(
          builder: ((context) => BlocProvider.value(
              value: locator<StatusScreenCubit>()..getOrders(),
              child: const StatusOrderScreen())),
        );
      case RouteName.Notification:
        return MaterialPageRoute(
          builder: ((context) => const NotificationItemWidget()),
        );
      default:
        return null;
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
