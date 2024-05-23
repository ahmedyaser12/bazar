import 'package:book_shop/core/widget/bottom_sheet.dart';
import 'package:book_shop/screens/cart_screen/ui/widget/bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/styles.dart';
import '../../logic/card_screen_cubit.dart';

class DateTimeWidget extends StatefulWidget {
  const DateTimeWidget({
    super.key,
  });

  @override
  State<DateTimeWidget> createState() => _DateTimeWidgetState();
}

class _DateTimeWidgetState extends State<DateTimeWidget> {
  String? dateTime;

  @override
  Widget build(BuildContext context) {
    dateTime = context.read<CardScreenCubit>().dateTimeString;
    return BlocBuilder<CardScreenCubit, CardScreenState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
            border: Border.all(
                color: !context.read<CardScreenCubit>().isTimeTaken
                    ? AppColors.redColor
                    : AppColors.greyColor,
                width: 1),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Date and time:',
                style: TextStyles.font18BlackBold(context),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(40)),
                      color: AppColors.secondary),
                  child: Icon(
                    Icons.calendar_month_outlined,
                    color: AppColors.primary,
                  ),
                ),
                title: Text(
                  'Date & time',
                  style: TextStyles.font14BlackSemi(context),
                ),
                subtitle: Text(
                    dateTime != null
                        ? '${dateTime!}'
                            ' ${context.read<CardScreenCubit>().dateTime!.year.toString()}'
                        : 'Choose date and time',
                    style: TextStyles.font14BlackSemi(context)),
                trailing: const Icon(Icons.chevron_right),
                onTap: () async {
                  await bottomSheet(
                    maxHeight: 0.5,
                    context,
                    buildBody: BlocProvider.value(
                      value: BlocProvider.of<CardScreenCubit>(context),
                      child: const BottomSheetContent(),
                    ),
                  );
                  setState(() {
                    dateTime =
                        context.read<CardScreenCubit>().dateTime.toString();
                    context
                        .read<CardScreenCubit>()
                        .addDeliveryTimeAndLocation();
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }

  String getDate(int index) {
    if (index == 0) {
      return 'today';
    } else if (index == 1) {
      return 'tomorrow';
    } else {
      return 'Pick';
    }
  }
}
