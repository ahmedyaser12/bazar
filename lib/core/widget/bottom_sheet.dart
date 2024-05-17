import 'package:book_shop/core/utils/colors.dart';
import 'package:flutter/material.dart';

Future bottomSheet(
  BuildContext context, {double? maxHeight,
  required Widget buildBody,
}) {
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 0.4,
      // 40% of screen height
      minChildSize: 0.2,
      // 20% of screen height
      maxChildSize: maxHeight ?? 0.6,
      expand: false,
      //Full screen
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                buildBody,
              ],
            ),
          ),
        );
      },
    ),
  );
}
