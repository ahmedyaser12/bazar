import 'package:book_shop/config/routs/app_router.dart';
import 'package:book_shop/config/routs/routs_names.dart';
import 'package:book_shop/generated/l10n.dart';
import 'package:book_shop/screens/favorite_screen/logic/favorite_cubit.dart';
import 'package:book_shop/services/observer.dart';
import 'package:book_shop/services/services_locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'core/cubits/cubit_theme/theme_cubit.dart';
import 'core/cubits/local_cubit/localization.dart';
import 'core/helper/cache_helper.dart';
import 'firebase_options.dart';
import 'services/firebase_service.dart';

final navKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initNotification();
  Bloc.observer = MyBlocObserver();
  await setupLocator();
  await CacheHelper().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => FavoriteCubit()),
          BlocProvider(create: (context) => ThemeCubit()),
          BlocProvider(create: (context) => LocaleCubit()),
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, themeState) {
            return BlocBuilder<LocaleCubit, Locale>(
              builder: (context, locale) {
                return MaterialApp(
                  locale: locale,
                  localizationsDelegates: const [
                    S.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: S.delegate.supportedLocales,
                  useInheritedMediaQuery: true,
                  debugShowCheckedModeBanner: false,
                  theme: themeState.themeData,
                  initialRoute: CacheHelper().getData(key: 'login') == true
                      ? RouteName.NAV
                      : RouteName.ONBOARDING,
                  onGenerateRoute: AppRouter.generateRoute,
                  builder: (context, child) {
                    return child!;
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  bool isArabic() {
    return Intl.getCurrentLocale() == "ar";
  }
}
