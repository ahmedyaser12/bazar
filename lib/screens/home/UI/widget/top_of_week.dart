import 'package:book_shop/core/utils/common_functions.dart';
import 'package:book_shop/screens/home/UI/widget/header_of_tops.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/styles.dart';
import '../../data/model.dart';

class TopOfWeekWidget extends StatelessWidget {
  final List<TopWeakModel> topWeakList;

  const TopOfWeekWidget({super.key, required this.topWeakList});

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
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        child: Image.network(
                          topWeakList[index].cover.toString(),
                          width: 150,
                        ),
                      ),
                      heightSpace(4),
                      SizedBox(
                        width:130,
                        child: Text(
                          topWeakList[index].name.toString(),
                          style: TextStyles.font14BlackSemi,softWrap: true,maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                );
              }),
        )
      ],
    );
  }
}
