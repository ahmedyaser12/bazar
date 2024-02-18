import 'package:book_shop/config/routs/routs_names.dart';
import 'package:book_shop/core/utils/colors.dart';
import 'package:book_shop/core/utils/common_functions.dart';
import 'package:book_shop/core/utils/extintions.dart';
import 'package:book_shop/core/widget/custom_appBar.dart';
import 'package:book_shop/core/widget/divider_widget.dart';
import 'package:book_shop/core/widget/favoutite_button.dart';
import 'package:book_shop/services/firebase_service.dart';
import 'package:book_shop/services/services_locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/styles.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = locator<FirebaseService>().getCurrentUser();
    return Column(
      children: [
        CustomAppBar(
          title: 'Profile',
          iconThemeData: IconThemeData(color: AppColors.blackColor),
          color: AppColors.whiteColor,
        ),
        heightSpace(20),
        const DividerWidget(),
        ListTile(
          horizontalTitleGap: .5,
          contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
          titleAlignment: ListTileTitleAlignment.top,
          leading: const CircleAvatar(
            foregroundImage: AssetImage('assets/images/img_2.png'),
            radius: 50,
          ),
          title: Text(user!.displayName.toString(),
              style: TextStyles.font18BlackBold),
          trailing: Padding(
            padding: const EdgeInsets.only(top: 15, right: 15),
            child: Text(
              'Logout',
              style: TextStyle(color: AppColors.redColor, fontSize: 15),
            ).onTap(() {
              FirebaseAuth.instance.signOut();
            }),
          ),
          subtitle: Text(
            user.email.toString(),
            style: TextStyles.font16grey.copyWith(fontSize: 15),
          ),
        ),
        const DividerWidget(),
        heightSpace(16),
        ListTile(
          title: const Text('My Account'),
          leading: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(40)),
                color: AppColors.secondary),
            child: Icon(
              Icons.person,
              color: AppColors.primary,
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios_outlined,
            color: AppColors.gery50,
          ),
        ),
        ListTile(
          title: const Text('Your Favourite'),
          leading: FavouriteButton(backgroundColor: AppColors.secondary),
          trailing: Icon(
            Icons.arrow_forward_ios_outlined,
            color: AppColors.gery50,
          ),
          onTap: (() {
            context.navigateTo(RouteName.FAVOURITE);
          }),
        ),
        ListTile(
          title: const Text('order history'),
          leading: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(40)),
                color: AppColors.secondary),
            child: Icon(
              Icons.document_scanner_rounded,
              color: AppColors.primary,
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios_outlined,
            color: AppColors.gery50,
          ),
        ),
        ListTile(
          title: const Text('Help Center'),
          leading: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(40)),
                color: AppColors.secondary),
            child: Icon(
              Icons.message,
              color: AppColors.primary,
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios_outlined,
            color: AppColors.gery50,
          ),
        ),
      ],
    );
  }
}
