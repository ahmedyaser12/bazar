import 'package:book_shop/core/utils/colors.dart';
import 'package:book_shop/core/utils/common_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/styles.dart';
import '../../logic/book_details_cubit.dart';

class CounterButtons extends StatefulWidget {
  final Function(int) num;

  const CounterButtons({super.key, required this.num});

  @override
  State<CounterButtons> createState() => _CounterButtonState();
}

class _CounterButtonState extends State<CounterButtons> {
  late int counter;

  @override
  void initState() {
    counter = context.read<BookDetailsCubit>().getProductNumber();
    super.initState();
  }

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
              if (counter <= 1) {
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
          style: TextStyles.font18BlackBold(context),
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
