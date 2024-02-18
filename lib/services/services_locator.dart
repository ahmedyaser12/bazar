import 'package:book_shop/screens/book_detailes_screen/logic/book_details_cubit.dart';
import 'package:book_shop/screens/categories/logic/categories_cubit.dart';
import 'package:book_shop/screens/home/logic/home_cubit.dart';
import 'package:book_shop/screens/login_screen/logic/login_cubit.dart';
import 'package:book_shop/screens/onboarding_screen/logic/onboarding_cubit.dart';
import 'package:book_shop/screens/search_screen/logic/search_screen_cubit.dart';
import 'package:book_shop/screens/sign_up_screen/logic/sign_up_cubit.dart';
import 'package:book_shop/services/api_services/dioconsumer.dart';
import 'package:book_shop/services/firebase_service.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import '../screens/author_details_screen/logic/author_details_cubit.dart';
import 'api_services/api_service.dart';

GetIt locator = GetIt.instance;
FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

Future setupLocator() async {
  locator.registerLazySingleton<ApiService>(
    () => ApiService(locator()),
  );
  locator.registerLazySingleton(() => Dio());
  locator.registerLazySingleton(() => DioConsumer(locator()));
  locator.registerFactory<FirebaseService>(() => FirebaseService());
  locator.registerFactory<LoginCubit>(
      () => LoginCubit(locator<FirebaseService>(), _firebaseAuth));
  locator.registerFactory<SignUpCubit>(
      () => SignUpCubit(locator<FirebaseService>(), _firebaseAuth));
  locator
      .registerLazySingleton<HomeCubit>(() => HomeCubit(locator<ApiService>()));
  locator.registerLazySingleton<BookDetailsCubit>(
      () => BookDetailsCubit(locator<ApiService>()));
  locator.registerLazySingleton<OnboardingCubit>(() => OnboardingCubit());
  locator.registerLazySingleton<AuthorDetailsCubit>(
      () => AuthorDetailsCubit(locator()));
  locator
      .registerLazySingleton<CategoriesCubit>(() => CategoriesCubit(locator()));
  locator.registerLazySingleton<SearchCubit>(() => SearchCubit(locator()));
}
