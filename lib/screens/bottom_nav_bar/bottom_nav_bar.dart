import 'package:book_shop/screens/categories/logic/categories_cubit.dart';
import 'package:book_shop/screens/categories/ui/categories_screens.dart';
import 'package:book_shop/screens/home/UI/home.dart';
import 'package:book_shop/screens/profile_screen/logic/profile_screen_cubit.dart';
import 'package:book_shop/screens/profile_screen/ui/profile_screen.dart';
import 'package:book_shop/services/services_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/colors.dart';
import '../cart_screen/ui/card_screen.dart';
import '../home/logic/home_cubit.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentNavIndex = 2;

  // Method to get the current page based on the navigation index
  Widget _getCurrentPage() {
    switch (currentNavIndex) {
      case 0:
        return BlocProvider(
          create: (_) => locator<HomeCubit>(),
          child: const HomeScreen(),
        );
      case 1:
        return BlocProvider.value(
          value: locator<CategoriesCubit>(),
          child: const CategoriesScreens(),
        );
      case 2:
        return const CartScreen();
      case 3:
        return BlocProvider.value(
          value: locator<ProfileScreenCubit>(),
          child: const ProfileScreen(),
        );
      default:
        return const Center(
            child: Icon(
          Icons.person_off,
          size: 50,
        )); // Fallback to HomePage in case of unexpected index
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: currentNavIndex == 0,
      onPopInvoked: (_) {
        if (currentNavIndex != 0) {
          setState(() {
            currentNavIndex = 0;
          });
          // Prevents the app from exiting
        } // Exits the app
      },
      child: Scaffold(
          body: _getCurrentPage(), // Use the method to switch pages
          bottomNavigationBar: Stack(
            children: [
                Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 60,
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.white, // Custom shadow color
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
            ),
          ),
              BottomNavigationBar(
              elevation: 5,
              type: BottomNavigationBarType.fixed,
              currentIndex: currentNavIndex,
              onTap: (index) {
                setState(() {
                  currentNavIndex = index;
                  print('$currentNavIndex&$index');
                });
              },
              selectedItemColor: AppColors.primary,
              unselectedItemColor: AppColors.greyColor,
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/svgs/Home.svg',
                    color: currentNavIndex == 0
                        ? AppColors.primary
                        : AppColors.greyColor,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/svgs/Document.svg',
                    color: currentNavIndex == 1
                        ? AppColors.primary
                        : AppColors.greyColor,
                  ),
                  label: 'Category',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/svgs/Buy.svg',
                    color: currentNavIndex == 2
                        ? AppColors.primary
                        : AppColors.greyColor,
                  ),
                  label: 'Cart',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/svgs/Profile.svg',
                    color: currentNavIndex == 3
                        ? AppColors.primary
                        : AppColors.greyColor,
                  ),
                  label: 'Profile',
                ),
              ],
            ),]
          )),
    );
  }
}
