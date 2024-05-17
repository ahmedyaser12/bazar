import 'package:book_shop/config/routs/routs_names.dart';
import 'package:book_shop/core/utils/colors.dart';
import 'package:book_shop/core/utils/common_functions.dart';
import 'package:book_shop/core/utils/extintions.dart';
import 'package:book_shop/core/widget/custom_appBar.dart';
import 'package:book_shop/core/widget/divider_widget.dart';
import 'package:book_shop/core/widget/favoutite_button.dart';
import 'package:book_shop/screens/profile_screen/logic/profile_screen_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
        ),
        heightSpace(20),
        const DividerWidget(),
        BlocBuilder<ProfileScreenCubit, ProfileScreenState>(
          builder: (context, state) {
            if (state is LoadingUser) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              final user = context.read<ProfileScreenCubit>().userModel!.user;
              return ListTile(
                horizontalTitleGap: .5,
                contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                titleAlignment: ListTileTitleAlignment.top,
                leading: CachedNetworkImage(
                  alignment: Alignment.center,
                  imageUrl: user!.profilePic!,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  imageBuilder: (context, imageProvider) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    height: 60,
                    width: 55,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fill, // Start with BoxFit.cover
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
                title: Text(user.name.toString(),
                    style: TextStyles.font18BlackBold(context)),
                trailing: Padding(
                  padding: const EdgeInsets.only(top: 15, right: 15),
                  child: Text(
                    'Logout',
                    style: TextStyle(color: AppColors.redColor, fontSize: 15),
                  ).onTap(() {
                    //context.navigateToAndReplacement(RouteName.LOGIN);
                  }),
                ),
                subtitle: Text(
                  user.email.toString(),
                  style: TextStyles.font16grey(context).copyWith(fontSize: 15),
                ),
              );
            }
          },
        ),
        const DividerWidget(),
        heightSpace(16),
        ListTile(
          onTap: () async {
            await context.navigateTo(RouteName.MYACCOUNT,
                argument: context.read<ProfileScreenCubit>().userModel);
            if (mounted) {
              context.read<ProfileScreenCubit>().getUser();
            }
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
