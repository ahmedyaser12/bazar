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
          '${authorDetails.name}',
          style: TextStyles.font18BlackBold,
        ),
        heightSpace(24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(children: List.generate(5, (index) => const Icon(Icons.star))),
            widthSpace(6),
            Text(authorDetails.rating.toString()),
          ],
        ),
      ],
    );
  }
}
