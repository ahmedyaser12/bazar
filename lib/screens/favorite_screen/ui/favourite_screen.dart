import 'package:book_shop/core/utils/colors.dart';
import 'package:book_shop/core/utils/common_functions.dart';
import 'package:book_shop/core/widget/custom_appBar.dart';
import 'package:book_shop/core/widget/favoutite_button.dart';
import 'package:book_shop/screens/favorite_screen/logic/favorite_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/styles.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          if (state is GetFavoriteList) {
            return state.favoriteList.isNotEmpty
                ? Column(
                    children: [
                      CustomAppBar(
                        title: 'Favourite',
                        iconThemeData: const IconThemeData(),
                        color: AppColors.whiteColor,
                      ),
                      heightSpace(16),
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.favoriteList.length,
                          itemBuilder: (ct, index) {
                            return ListTile(
                              horizontalTitleGap: .5,
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 3.0),
                              titleAlignment: ListTileTitleAlignment.top,
                              leading: SizedBox(
                                width: 100,
                                child: Center(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    child: Image.network(
                                      state.favoriteList[index].image!,
                                      fit: BoxFit.fill,
                                      width: 70,
                                      height: 100,
                                    ),
                                  ),
                                ),
                              ),
                              title: Text(
                                  state.favoriteList[index].name.toString(),
                                  style: TextStyles.font18BlackBold),
                              subtitle: Text(
                                state.favoriteList[index].rating.toString(),
                                style: TextStyles.font16grey
                                    .copyWith(fontSize: 15),
                              ),
                              trailing: FavouriteButton(
                                  backgroundColor: AppColors.whiteColor,
                                  checkFavorite: context
                                      .read<FavoriteCubit>()
                                      .isFavorite(state.favoriteList[index]),
                                  deleteFavorite: () {
                                    context
                                        .read<FavoriteCubit>()
                                        .deleteFavorite(
                                            state.favoriteList[index]);
                                  }),
                            );
                          },
                        ),
                      ),
                    ],
                  )
                : const Center(
                    child: Text('No Favourite Added '),
                  );
          }
          return const Center(
            child: Text('No Favourite Added '),
          );
        },
      ),
    );
  }
}
