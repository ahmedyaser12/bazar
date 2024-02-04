import 'package:book_shop/core/utils/common_functions.dart';
import 'package:book_shop/core/utils/extintions.dart';
import 'package:book_shop/screens/home/UI/widget/header_of_tops.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/styles.dart';
import '../../data/top_book_of_weak_model.dart';

class TopOfWeekWidget extends StatelessWidget {
  final List<TopWeakModel> topWeakList;
  final void Function(TopWeakModel? model) onTab;

  const TopOfWeekWidget(
      {super.key, required this.topWeakList, required this.onTab});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Header(header: 'Top Of Week'),
        //heightSpace(5),
        Expanded(
          child: ListView.builder(
              itemCount: topWeakList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 8.0.h),
                  child: buildColumn(index).onTap(() {
                    print('idbooktop${topWeakList[index].bookId!}');
                    onTab(topWeakList[index]);
                  }),
                );
              }),
        )
      ],
    );
  }

  Column buildColumn(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          child: Image.network(
            topWeakList[index].cover.toString(),
            width: 150.w,
            height: 240,
            fit: BoxFit.fill,
          ),
        ),
        heightSpace(3),
        Container(
          constraints: BoxConstraints(maxWidth: 150.w),
          child: Text(
            topWeakList[index].name.toString(),
            style: TextStyles.font14BlackSemi.copyWith(height: 1),
            softWrap: true,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
