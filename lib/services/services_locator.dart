import 'package:book_shop/screens/book_detailes_screen/logic/book_details_cubit.dart';
import 'package:book_shop/screens/cart_screen/logic/card_screen_cubit.dart';
import 'package:book_shop/screens/categories/logic/categories_cubit.dart';
import 'package:book_shop/screens/favorite_screen/logic/favorite_cubit.dart';
import 'package:book_shop/screens/home/logic/home_cubit.dart';
import 'package:book_shop/screens/login_screen/logic/login_cubit.dart';
import 'package:book_shop/screens/onboarding_screen/logic/onboarding_cubit.dart';
import 'package:book_shop/screens/payment_screen/logic/payment_cubit.dart';
import 'package:book_shop/screens/profile_screen/logic/profile_screen_cubit.dart';
import 'package:book_shop/screens/search_screen/logic/search_screen_cubit.dart';
import 'package:book_shop/screens/sign_up_screen/logic/sign_up_cubit.dart';
import 'package:book_shop/screens/status_order_screen/logic/status_screen_cubit.dart';
import 'package:book_shop/services/firebase_service.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../screens/author_details_screen/logic/author_details_cubit.dart';
import 'api_services/api_service.dart';

GetIt locator = GetIt.instance;

Future setupLocator() async {
  locator.registerLazySingleton<ApiService>(
    () => ApiService(),
  );
  locator.registerLazySingleton(() => Dio());
  // locator.registerFactoryParam<DioConsumer, String, String>(
  //   (header, baseUrl) =>
  //       DioConsumer(dio: locator(), header, null, baseUrl: baseUrl),
  // );
  locator.registerLazySingleton<LoginCubit>(() => LoginCubit(locator()));
  locator.registerLazySingleton<PaymentCubit>(
      () => PaymentCubit(locator<ApiService>(), locator<FirebaseService>()));
  locator.registerLazySingleton<SignUpCubit>(() => SignUpCubit(locator()));
  locator.registerLazySingleton<ProfileScreenCubit>(
      () => ProfileScreenCubit(locator()));
  locator
      .registerLazySingleton<HomeCubit>(() => HomeCubit(locator<ApiService>()));
  locator.registerLazySingleton<CardScreenCubit>(
      () => CardScreenCubit(locator<FirebaseService>()));
  locator.registerLazySingleton<FirebaseService>(() => FirebaseService());
  locator.registerLazySingleton<BookDetailsCubit>(() =>
      BookDetailsCubit(locator<ApiService>(), locator<FirebaseService>()));
  locator.registerLazySingleton<OnboardingCubit>(() => OnboardingCubit());
  locator.registerLazySingleton<AuthorDetailsCubit>(
      () => AuthorDetailsCubit(locator()));
  locator
      .registerLazySingleton<CategoriesCubit>(() => CategoriesCubit(locator()));
  locator.registerLazySingleton<SearchCubit>(() => SearchCubit(locator()));
  locator.registerLazySingleton<FavoriteCubit>(() => FavoriteCubit());
  locator.registerLazySingleton<StatusScreenCubit>(
      () => StatusScreenCubit(locator()));
}
