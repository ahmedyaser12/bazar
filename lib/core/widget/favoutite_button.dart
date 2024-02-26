import 'package:book_shop/core/utils/extintions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FavouriteButton extends StatelessWidget {
  final Color backgroundColor;
  final void Function()? addFavorite;
  final void Function()? deleteFavorite;
  final bool checkFavorite;

  const FavouriteButton({
    super.key,
    required this.backgroundColor,
    this.addFavorite,
    this.checkFavorite = true,
    this.deleteFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(13),
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(40)),
        color: backgroundColor,
      ),
      child: checkFavorite
          ? SvgPicture.asset('assets/svgs/Heart.svg').onTap(() {
              deleteFavorite!();
            })
          : SvgPicture.asset('assets/svgs/Heart_black.svg').onTap(() {
              addFavorite!();
            }),
    );
  }
}
