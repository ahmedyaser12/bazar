import 'package:book_shop/core/utils/common_functions.dart';
import 'package:book_shop/core/utils/extintions.dart';
import 'package:book_shop/core/utils/styles.dart';
import 'package:book_shop/screens/home/UI/widget/header_of_tops.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/top_author_model.dart';

class AuthorWidget extends StatelessWidget {
  final List<TopAuthorsModel> authorsList;
  final List<Animation<Offset>>? position;

  final void Function(TopAuthorsModel? model) onTab;

  const AuthorWidget(
      {super.key,
      required this.authorsList,
      required this.onTab,
      required this.position});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Set size as a fraction of screen width
    double avatarSize =
        MediaQuery.of(context).orientation == Orientation.landscape
            ? screenWidth * 0.06
            : screenWidth * 0.1;
    return Column(
      children: [
        const Header(header: 'Authors'),
        Expanded(
          child: ListView.builder(
              itemCount: 5,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 8.0.h),
                  child: position != null
                      ? SlideTransition(
                          position: position![index],
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                  authorsList[(index * 2 + 5)].image.toString(),
                                ),
                                radius: avatarSize,
                              ),
                              heightSpace(15),
                              Container(
                                constraints: const BoxConstraints(
                                    maxWidth: 80, minWidth: 80),
                                child: Text(
                                  '${authorsList[index * 2 + 5].name}',
                                  style: TextStyles.font18BlackBold(context)
                                      .copyWith(fontSize: 13),
                                  softWrap: true,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              heightSpace(5),
                              Text(
                                authorsList[index * 2 + 5]
                                    .numberPublishedBooks
                                    .toString(),
                                style: TextStyles.font16grey(context)
                                    .copyWith(fontSize: 13),
                              )
                            ],
                          ).onTap(() {
                            onTab(authorsList[index * 2 + 5]);
                          }),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                authorsList[(index * 2 + 5)].image.toString(),
                              ),
                              radius: avatarSize,
                            ),
                            heightSpace(15),
                            Container(
                              constraints: const BoxConstraints(
                                  maxWidth: 80, minWidth: 80),
                              child: Text(
                                '${authorsList[index * 2 + 5].name}',
                                style: TextStyles.font18BlackBold(context)
                                    .copyWith(fontSize: 13),
                                softWrap: true,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            heightSpace(5),
                            Text(
                              authorsList[index * 2 + 5]
                                  .numberPublishedBooks
                                  .toString(),
                              style: TextStyles.font16grey(context)
                                  .copyWith(fontSize: 13),
                            )
                          ],
                        ).onTap(() {
                          onTab(authorsList[index * 2 + 5]);
                        }),
                );
              }),
        )
      ],
    );
  }
}
