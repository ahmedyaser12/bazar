import 'package:book_shop/screens/book_detailes_screen/data/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/styles.dart';

class TitleAndFavourite extends StatelessWidget {
  final BookDetailsModel bookDetails;

  const TitleAndFavourite({
    super.key,
    required this.bookDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${bookDetails.name}',
          style: TextStyles.font18BlackBold,
        ),
        SvgPicture.asset('assets/svgs/Heart.svg'),
      ],
    );
  }
}
