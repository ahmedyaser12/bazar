import 'package:book_shop/screens/home/logic/home_cubit.dart';
import 'package:book_shop/screens/login_screen/logic/login_cubit.dart';
import 'package:book_shop/screens/onboarding_screen/logic/onboarding_cubit.dart';
import 'package:book_shop/screens/sign_up_screen/logic/sign_up_cubit.dart';
import 'package:book_shop/services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import '../core/utils/constant.dart';
import 'api_service.dart';

GetIt locator = GetIt.instance;
FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

Future setupLocator() async {
  locator.registerLazySingleton<ApiService>(
      () => ApiService(AppConstance.baseUrl));

  locator.registerFactory<FirebaseService>(() => FirebaseService());
  locator.registerFactory<LoginCubit>(
      () => LoginCubit(locator<FirebaseService>(), _firebaseAuth));
  locator.registerFactory<SignUpCubit>(
      () => SignUpCubit(locator<FirebaseService>(), _firebaseAuth));
  locator
      .registerLazySingleton<HomeCubit>(() => HomeCubit(locator<ApiService>()));
  locator.registerLazySingleton<OnboardingCubit>(() => OnboardingCubit());
}
