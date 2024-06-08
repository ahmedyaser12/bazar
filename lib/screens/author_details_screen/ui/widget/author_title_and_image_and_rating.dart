import 'package:book_shop/core/widget/rating_widget.dart';
import 'package:book_shop/generated/l10n.dart';
import 'package:book_shop/screens/author_details_screen/data/author_model.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/common_functions.dart';
import '../../../../core/utils/styles.dart';

class AuthorTitleAndImageAndRating extends StatelessWidget {
  final AuthorDetailsModel authorDetails;

  const AuthorTitleAndImageAndRating({super.key, required this.authorDetails});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(authorDetails.image.toString()),
          radius: 50,
        ),
        heightSpace(16),
        Text(
          '${S.of(context).translateMessage(authorDetails.name!)} ${authorDetails.name}',
          style: TextStyles.font18BlackBold(context),
          textAlign: TextAlign.center,

        ),
        heightSpace(24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RatingWidget(rating: authorDetails.rating!),
            widthSpace(6),
            Text(authorDetails.rating.toString()),
          ],
        ),
      ],
    );
  }
}
