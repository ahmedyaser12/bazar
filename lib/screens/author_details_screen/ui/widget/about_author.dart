import 'package:book_shop/core/utils/common_functions.dart';
import 'package:book_shop/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:read_more_text/read_more_text.dart';

import '../../../../core/utils/styles.dart';
import '../../data/author_model.dart';

class AboutAuthor extends StatelessWidget {
  final AuthorDetailsModel authorDetails;

  const AboutAuthor({super.key, required this.authorDetails});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(S.of(context).about, style: TextStyles.font15BlackMedium(context)),
        heightSpace(8),
        ReadMoreText(
          authorDetails.info.toString(),
          numLines: 4,
          readMoreText: S.of(context).Read_more,
          readLessText: S.of(context).Read_less,
          style: TextStyles.font16grey(context),
        )
      ],
    );
  }
}
