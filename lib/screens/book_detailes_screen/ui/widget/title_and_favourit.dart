import 'package:book_shop/core/utils/colors.dart';
import 'package:book_shop/core/widget/favoutite_button.dart';
import 'package:book_shop/screens/book_detailes_screen/data/model.dart';
import 'package:book_shop/screens/favorite_screen/logic/favorite_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/styles.dart';

class TitleAndFavourite extends StatelessWidget {
  final BookDetailsModel bookDetails;

  const TitleAndFavourite({
    super.key,
    required this.bookDetails,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        var checkFavorite = context.read<FavoriteCubit>();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              constraints:  const BoxConstraints(
                maxWidth: 270,
              ) ,
              child: Text(
                '${bookDetails.name}',
                style: TextStyles.font18BlackBold(context),
              ),
            ),
            FavouriteButton(
              backgroundColor:Theme.of(context).brightness == Brightness.dark ? AppColors.darkBlue : AppColors.whiteColor,
              addFavorite: () {
                checkFavorite.addFavorite(bookDetails);
                print('add');
              },
              checkFavorite: checkFavorite.isFavorite(bookDetails),
              deleteFavorite: () {
                checkFavorite.deleteFavorite(bookDetails);
                print('delete');
              },
            )
          ],
        );
      },
    );
  }
}
