import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/colors.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    int currentNavIndex = 2;
    return BottomNavigationBar(
      elevation: 5,
      backgroundColor: AppColors.whiteColor,
      type: BottomNavigationBarType.fixed,
      currentIndex: currentNavIndex,
      onTap: (index) {
        setState(() {
          currentNavIndex = index;
        });
      },
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.greyColor,
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/svgs/Home.svg',
            color: currentNavIndex == 0 ? AppColors.primary : AppColors.greyColor,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/svgs/Document.svg',
            color: currentNavIndex == 1 ? AppColors.primary : AppColors.greyColor,
          ),
          label: 'Assets',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/svgs/Buy.svg',
            color: currentNavIndex == 2 ? AppColors.primary : AppColors.greyColor,
          ),
          label: 'Support',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/svgs/Profile.svg',
            color: currentNavIndex == 3 ? AppColors.primary : AppColors.greyColor,
          ),
          label: 'Profile',
        ),
      ],
    )
    ;
  }
}
//  currentNavIndex == 2 ? AppColors.primary : AppColors.greyColor,
//
