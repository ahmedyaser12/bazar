import 'package:book_shop/core/utils/common_functions.dart';
import 'package:book_shop/core/utils/styles.dart';
import 'package:book_shop/screens/search_screen/data/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
            child: Image.network(
              searchModel.image!,
              fit: BoxFit.fill,
              height: 90,
              width: 90,
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
                    style: TextStyles.font18BlackBold,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  heightSpace(8),
                  Text(searchModel.rating.toString()),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 35),
            child: SvgPicture.asset('assets/svgs/Heart.svg', height: 30),
          ),
        ],
      ),
    );
  }
}
