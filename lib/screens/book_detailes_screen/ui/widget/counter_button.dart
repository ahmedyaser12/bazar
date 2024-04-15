import 'package:book_shop/core/utils/colors.dart';
import 'package:book_shop/core/utils/common_functions.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/styles.dart';

class CounterButtons extends StatefulWidget {
  final Function(int) num;

  const CounterButtons({super.key, required this.num});

  @override
  State<CounterButtons> createState() => _CounterButtonState();
}

class _CounterButtonState extends State<CounterButtons> {
  int counter = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(AppColors.gery50),
          ),
          onPressed: () {
            setState(() {
              if (counter < 1) {
                return;
              }
              counter--;
              widget.num(counter);
            });
          },
          child: Icon(
            Icons.remove,
            color: AppColors.greyColor,
          ),
        ),
        widthSpace(16),
        Text(
          counter.toString(),
          style: TextStyles.font18BlackBold,
        ),
        widthSpace(16),
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(AppColors.primary),
          ),
          onPressed: () {
            setState(() {
              counter++;
              widget.num(counter);
            });
          },
          child: Icon(Icons.add, color: AppColors.whiteColor),
        ),
      ],
    );
  }
}
