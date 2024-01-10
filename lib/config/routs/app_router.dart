import 'package:book_shop/config/routs/routs_names.dart';
import 'package:book_shop/screens/home/logic/home_cubit.dart';
import 'package:book_shop/screens/login_screen/logic/login_cubit.dart';
import 'package:book_shop/screens/login_screen/ui/login_screen.dart';
import 'package:book_shop/screens/sign_up_screen/ui/sign_up_screen.dart';
import 'package:book_shop/screens/splash_screen/ui/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../screens/home/UI/home.dart';
import '../../screens/onboarding_screen/Ui/on_boarding_screen.dart';
import '../../screens/sign_up_screen/logic/sign_up_cubit.dart';
import '../../services/services_locator.dart';

// if (state is SignUpLoading) {
// return const CircularProgressIndicator();
// }
// if (state is SignUpSuccess) {
// context.navigateToAndReplacement(RouteName.HOME);
// }
// if (state is SignUpFailure) {
// context.pop();
// showDialog(
// context: context,
// builder: (context) => AlertDialog(
// icon: const Icon(
// Icons.error,
// color: Colors.red,
// size: 32,
// ),
// content: Text(
// state.error,
// style: TextStyles.font16PrimarySemi,
// ),
// actions: [
// TextButton(
// onPressed: () {
// context.pop();
// },
// child: Text(
// 'Got it',
// style: TextStyles.font16PrimarySemi,
// ),
// ),
// ],
// ),
// );
// }
class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    LoginCubit loginCubitInstant = locator<LoginCubit>();
    switch (settings.name) {
      case RouteName.LOGIN:
        return MaterialPageRoute(
          builder: ((context) => BlocProvider(
                create: (_) => loginCubitInstant,
                child: StreamBuilder<User?>(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      // If the snapshot has data, it means a user is logged in.
                      if (snapshot.hasData) {
                        return BlocProvider(
                            create: (_) => locator<HomeCubit>(),
                            child:
                                const HomeScreen()); // User is logged in, navigate to the Home Page.
                      } else {
                        return const LoginScreen(); // User is not logged in, navigate to the Login Page.
                      }
                    }
                    return Container();
                  },
                ),
              )),
        );
      case RouteName.SPLASH:
        return MaterialPageRoute(
          builder: ((context) => BlocProvider<LoginCubit>(
                create: (BuildContext context) => locator<LoginCubit>(),
                child: const SplashScreen(),
              )),
        );
      case RouteName.HOME:
        return MaterialPageRoute(
          builder: ((context) => const HomeScreen()),
        );
      case RouteName.ONBOARDING:
        return MaterialPageRoute(
          builder: ((context) => BlocProvider.value(
                value: loginCubitInstant,
                child: const OnboardingView(),
              )),
        );
      case RouteName.SIGNUP:
        return MaterialPageRoute(
          builder: ((context) => StreamBuilder<User?>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    // If the snapshot has data, it means a user is logged in.
                    if (snapshot.hasData) {
                      return BlocProvider(
                          create: (_) => locator<HomeCubit>(),
                          child: const HomeScreen());
                    } else {
                      return BlocProvider(
                          create: (_) => locator<SignUpCubit>(),
                          child:
                              const SignUpScreen()); // User is not logged in, navigate to the Login Page.
                    }
                  }
                  return Container();
                },
              )),
        );
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
