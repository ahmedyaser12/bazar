import 'package:book_shop/core/utils/colors.dart';
import 'package:book_shop/core/utils/common_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/styles.dart';
import '../../logic/book_details_cubit.dart';

class CounterButtons extends StatelessWidget {
  const CounterButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(AppColors.gery50),
          ),
          onPressed: () {
            context.read<BookDetailsCubit>().isExist
                ? null
                : context.read<BookDetailsCubit>().counterMinus();
          },
          child: Icon(
            Icons.remove,
            color: AppColors.greyColor,
          ),
        ),
        widthSpace(16),
        Text(
          context.watch<BookDetailsCubit>().counter.toString(),
          style: TextStyles.font18BlackBold(context),
        ),
        widthSpace(16),
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
                context.read<BookDetailsCubit>().isExist
                    ? AppColors.gery50
                    : AppColors.primary),
          ),
          onPressed: () {
            context.read<BookDetailsCubit>().isExist
                ? null
                : context.read<BookDetailsCubit>().counterPlus();
          },
          child: Icon(Icons.add, color: AppColors.whiteColor),
        ),
      ],
    );
  }
}
