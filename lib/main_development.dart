import 'package:book_shop/config/routs/app_router.dart';
import 'package:book_shop/config/routs/routs_names.dart';
import 'package:book_shop/screens/favorite_screen/logic/favorite_cubit.dart';
import 'package:book_shop/services/observer.dart';
import 'package:book_shop/services/services_locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/helper/cache_helper.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = MyBlocObserver();
  await setupLocator();
  CacheHelper().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.blue, // Set any color you want here
      statusBarBrightness: Brightness
          .dark, // Use Brightness.light for light status bar, or Brightness.dark for dark status bar
    ));
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: BlocProvider(
        create: (context) => FavoriteCubit(),
        child: MaterialApp(
          useInheritedMediaQuery: true,
          // locale: DevicePreview.locale(context),
          // builder: DevicePreview.appBuilder,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(),
          initialRoute: CacheHelper().getData(key: 'login') == true
              ? RouteName.NAV
              : RouteName.ONBOARDING,
          onGenerateRoute: AppRouter.generateRoute,
        ),
      ),
    );
  }
}
