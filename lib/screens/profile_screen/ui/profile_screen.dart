import 'package:book_shop/config/routs/routs_names.dart';
import 'package:book_shop/core/utils/colors.dart';
import 'package:book_shop/core/utils/common_functions.dart';
import 'package:book_shop/core/utils/extintions.dart';
import 'package:book_shop/core/widget/custom_appBar.dart';
import 'package:book_shop/core/widget/divider_widget.dart';
import 'package:book_shop/core/widget/favoutite_button.dart';
import 'package:book_shop/screens/profile_screen/logic/profile_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/styles.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    context.read<ProfileScreenCubit>().userModel == null
        ? context.read<ProfileScreenCubit>().getUser()
        : null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(
          title: 'Profile',
          iconThemeData: IconThemeData(color: AppColors.blackColor),
          color: AppColors.whiteColor,
        ),
        heightSpace(20),
        const DividerWidget(),
        BlocBuilder<ProfileScreenCubit, ProfileScreenState>(
          builder: (context, state) {
            if (state is UserDetailsSuccess) {
              final user = state.userModel;
              return ListTile(
                horizontalTitleGap: .5,
                contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                titleAlignment: ListTileTitleAlignment.top,
                leading: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                    user.user!.profilePic.toString(),
                  ),
                  // padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  //  child: Image.network(
                  //    user.user!.profilePic.toString(),
                  //    fit: BoxFit.contain,
                  //  ),
                ),
                title: Text(user.user!.name.toString(),
                    style: TextStyles.font18BlackBold),
                trailing: Padding(
                  padding: const EdgeInsets.only(top: 15, right: 15),
                  child: Text(
                    'Logout',
                    style: TextStyle(color: AppColors.redColor, fontSize: 15),
                  ).onTap(() {}),
                ),
                subtitle: Text(
                  user.user!.email.toString(),
                  style: TextStyles.font16grey.copyWith(fontSize: 15),
                ),
              );
            }
            return Container();
          },
        ),
        const DividerWidget(),
        heightSpace(16),
        ListTile(
          onTap: () {
            context.navigateTo(RouteName.MYACCOUNT,
                argument: context.read<ProfileScreenCubit>().userModel);
          },
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
