import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FavouriteButton extends StatelessWidget {
  final Color backgroundColor;

  const FavouriteButton({super.key, required this.backgroundColor});

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
      child: SvgPicture.asset('assets/svgs/Heart.svg'),
    );
  }
}
