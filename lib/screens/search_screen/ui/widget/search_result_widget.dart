import 'package:book_shop/core/utils/common_functions.dart';
import 'package:book_shop/core/utils/extintions.dart';
import 'package:book_shop/core/utils/styles.dart';
import 'package:book_shop/core/widget/bottom_sheet.dart';
import 'package:book_shop/screens/search_screen/data/model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/widget/rating_widget.dart';
import '../../../book_detailes_screen/ui/book_details.dart';

class SearchResultWidget extends StatelessWidget {
  final SearchModel searchModel;

  const SearchResultWidget({super.key, required this.searchModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
            child: CachedNetworkImage(
              imageUrl: searchModel.image!,
              fit: BoxFit.fill,
              width: 90,
              height: 90,
              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    searchModel.name!,
                    style: TextStyles.font15BlackMedium(context),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  heightSpace(8),
                  Row(
                    children: [
                      RatingWidget(rating: searchModel.rating!),
                      widthSpace(5),
                      Text(searchModel.rating.toString()),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ).onTap(() {
        bottomSheet(
          maxHeight: 1,
          context,
          buildBody: BookDetailsScreen(
            bookId: searchModel.id!,
          ),
        );
      }),
    );
  }
}
