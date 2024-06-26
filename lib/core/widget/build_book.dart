import 'package:book_shop/core/utils/extintions.dart';
import 'package:book_shop/screens/model/base_model.dart';
import 'package:flutter/material.dart';

import '../../screens/book_detailes_screen/ui/book_details.dart';
import '../utils/colors.dart';
import '../utils/common_functions.dart';
import '../utils/styles.dart';

class BuildBook extends StatelessWidget {
  final BaseModel categoryList;

  const BuildBook({super.key, required this.categoryList});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
            child: Image.network(
              categoryList.image.toString(),
              // width: 150,
              // height: 240,
              fit: BoxFit.fill,
            ),
          ),
        ),
        heightSpace(3),
        Container(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(maxWidth: 140),
          child: Text(
            categoryList.name.toString(),
            style: TextStyles.font14BlackSemi(context).copyWith(height: 1),
            softWrap: true,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ]).onTap(() {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) => DraggableScrollableSheet(
            initialChildSize: 0.4,
            // 40% of screen height
            minChildSize: 0.2,
            // 20% of screen height
            maxChildSize: 1.0,
            expand: false,
            //Full screen
            builder: (context, scrollController) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? AppColors.darkBlue
                        : Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    )),
                child: BookDetailsScreen(
                  scrollController: scrollController,
                  bookId: categoryList.id!,
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
