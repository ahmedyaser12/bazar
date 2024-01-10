import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/styles.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: AppColors.gery50,
            thickness: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            'Or with',
            style: TextStyles.font16grey,
          ),
        ),
        Expanded(
          child: Divider(
            color: AppColors.gery50,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
