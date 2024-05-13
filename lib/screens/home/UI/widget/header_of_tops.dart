import 'package:flutter/material.dart';

import '../../../../core/utils/styles.dart';

class Header extends StatelessWidget {
  final String header;

  const Header({super.key, required this.header});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          header,
          style: TextStyles.font18BlackBold,
        ),
        TextButton(
            onPressed: () {

            },
            child: Text(
              'See All',
              style: TextStyles.font14PrimarySemi,
            ))
      ],
    );
  }
}
