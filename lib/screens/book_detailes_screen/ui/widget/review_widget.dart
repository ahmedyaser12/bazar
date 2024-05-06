import 'package:book_shop/core/widget/rating_widget.dart';
import 'package:book_shop/screens/book_detailes_screen/data/model.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/common_functions.dart';
import '../../../../core/utils/styles.dart';

class ReviewWidget extends StatelessWidget {
  final BookDetailsModel bookDetails;

  const ReviewWidget({
    super.key,
    required this.bookDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Review',
          style: TextStyles.font18BlackBold,
        ),
        Row(
          children: [
            RatingWidget(rating: bookDetails.rating!),
            widthSpace(5),
            Text('${bookDetails.rating}')
          ],
        ),
      ],
    );
  }
}
