import 'package:book_shop/core/utils/common_functions.dart';
import 'package:book_shop/core/utils/extintions.dart';
import 'package:book_shop/core/utils/styles.dart';
import 'package:book_shop/screens/home/UI/widget/header_of_tops.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/top_author_model.dart';

class AuthorWidget extends StatelessWidget {
  final List<TopAuthorsModel> authorsList;
  final void Function(TopAuthorsModel? model) onTab;

  const AuthorWidget(
      {super.key, required this.authorsList, required this.onTab});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Header(header: 'Authors'),
        Expanded(
          child: ListView.builder(
              itemCount: authorsList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 8.0.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage(authorsList[5].image.toString()),
                        radius: 50,
                      ),
                      heightSpace(15),
                      Container(
                        constraints: const BoxConstraints(maxWidth: 120),
                        child: Text(
                          '${authorsList[index].name}',
                          style: TextStyles.font18BlackBold
                              .copyWith(fontSize: 13.sp),
                          softWrap: true,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      heightSpace(5),
                      Text(
                        authorsList[index].numberPublishedBooks.toString(),
                        style: TextStyles.font16grey.copyWith(fontSize: 13.sp),
                      )
                    ],
                  ).onTap(() {
                    onTab(authorsList[index]);
                  }),
                );
              }),
        )
      ],
    );
  }
}
