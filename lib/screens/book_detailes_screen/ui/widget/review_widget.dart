import 'package:book_shop/screens/book_detailes_screen/data/model.dart';
import 'package:flutter/material.dart';

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
            Row(children: List.generate(5, (index) => const Icon(Icons.star))),
            Text('${bookDetails.rating}')
          ],
        ),
      ],
    );
  }
}
