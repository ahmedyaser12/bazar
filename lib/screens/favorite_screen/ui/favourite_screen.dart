import 'package:book_shop/core/utils/colors.dart';
import 'package:book_shop/core/utils/common_functions.dart';
import 'package:book_shop/core/widget/custom_appBar.dart';
import 'package:book_shop/core/widget/favoutite_button.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/styles.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Column(
        children: [
          CustomAppBar(
            title: 'Favourite',
            iconThemeData: const IconThemeData(),
            color: AppColors.whiteColor,
          ),
          heightSpace(16),
          ListTile(
            horizontalTitleGap: .5,
            contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
            titleAlignment: ListTileTitleAlignment.top,
            leading: SizedBox(
              width: 70,
              height: 70,
              child: Center(
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Image.asset('assets/images/img_1.png'),
                ),
              ),
            ),
            title: Text('ahmed', style: TextStyles.font18BlackBold),
            trailing: FavouriteButton(backgroundColor: AppColors.whiteColor),
            subtitle: Text(
              'dsda',
              style: TextStyles.font16grey.copyWith(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
