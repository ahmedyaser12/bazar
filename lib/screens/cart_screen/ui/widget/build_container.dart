import 'package:book_shop/core/utils/extintions.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/styles.dart';

class BuildContainer extends StatefulWidget {
  final String name;
  final String date;
  final int index;

  const BuildContainer({
    super.key,
    required this.name,
    required this.date,
    required this.index,
  });

  @override
  State<BuildContainer> createState() => _BuildContainerState();
}

class _BuildContainerState extends State<BuildContainer> {
  int tappedDate = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      decoration: BoxDecoration(
        border: Border.all(
            color: tappedDate == widget.index
                ? AppColors.primary
                : AppColors.greyColor,
            width: 1.5),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        children: [
          Text(
            widget.name,
            style: TextStyles.font18BlackBold(context),
          ),
          Text(
            widget.date,
            style: TextStyles.font18BlackBold(context),
          ),
        ],
      ),
    ).onTap(() {
      setState(() {
        setState(() {
          tappedDate = widget.index;
        });
        print('${widget.index} $tappedDate ');
      });
    });
  }
}
