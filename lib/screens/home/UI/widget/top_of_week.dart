import 'package:book_shop/screens/home/UI/widget/header_of_tops.dart';
import 'package:flutter/material.dart';

import '../../../../core/widget/build_book.dart';
import '../../data/top_book_of_weak_model.dart';

class TopOfWeekWidget extends StatelessWidget {
  final List<TopWeakModel> topWeakList;

  const TopOfWeekWidget({
    super.key,
    required this.topWeakList,
  });

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
                return BuildBook(
                  categoryList: topWeakList[index],
                );
              }),
        )
      ],
    );
  }
}
