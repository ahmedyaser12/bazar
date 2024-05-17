import 'package:book_shop/core/utils/colors.dart';
import 'package:book_shop/core/utils/common_functions.dart';
import 'package:book_shop/core/utils/extintions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/styles.dart';
import '../../../../core/widget/app_buttons.dart';
import '../../logic/card_screen_cubit.dart';

class BottomSheetContent extends StatefulWidget {
  const BottomSheetContent({
    Key? key,
  }) : super(key: key);

  @override
  BottomSheetContentState createState() => BottomSheetContentState();
}

class BottomSheetContentState extends State<BottomSheetContent> {
  late int selectedDateIndex;

  late int selectedTimeIndex;

  String? pickedDate;

  @override
  void initState() {
    int today = DateTime.now().day;
    int tomorrow = DateTime.now().add(const Duration(days: 1)).day;

    if (context.read<CardScreenCubit>().dateTime == null) {
      selectedDateIndex = -1;
      selectedTimeIndex = -1;
    } else {
      int cubitDay = context.read<CardScreenCubit>().dateTime!.day;

      if (cubitDay == today) {
        selectedDateIndex = 0;
        selectedTimeIndex = 0;
      } else if (cubitDay == tomorrow) {
        selectedDateIndex = 1;
        selectedTimeIndex = 1;
      } else {
        selectedTimeIndex = 0;
        selectedDateIndex = 2;
      }
      pickedDate = context.read<CardScreenCubit>().dateTime!.day == today ||
              context.read<CardScreenCubit>().dateTime!.day == tomorrow
          ? null
          : context.read<CardScreenCubit>().dateTimeString;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Adjust size to content
        children: [
          const Text(
            'Select Date and Time',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          // Example list of dates
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(3, (index) {
              return ChoiceChip(
                showCheckmark: index == 2 ? false : true,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                selectedColor: AppColors.primary,
                checkmarkColor: AppColors.whiteColor,
                backgroundColor: AppColors.whiteColor,
                labelStyle: TextStyle(
                    color: index == selectedDateIndex
                        ? AppColors.whiteColor
                        : AppColors.blackColor),
                labelPadding: EdgeInsets.zero,
                label: BlocBuilder<CardScreenCubit, CardScreenState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        Text(getDate(index)),
                        Text(
                          index != 2
                              ? context
                                  .read<CardScreenCubit>()
                                  .switchFromDateDayToHisName(
                                      index + DateTime.now().day,
                                      DateTime.now().month)
                              : pickedDate != null
                                  ? context
                                      .read<CardScreenCubit>()
                                      .dateTime!
                                      .year
                                      .toString()
                                  : 'a date',
                        ),
                      ],
                    );
                  },
                ),
                selected: selectedDateIndex == index,
                onSelected: (bool selected) {
                  setState(() {
                    selectedDateIndex = index;
                  });
                  if (index == 2) {
                    showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(
                          2030, DateTime.now().month, DateTime.now().day),
                      initialDate: DateTime.now(),
                    ).then(
                      (value) {
                        if (value != null) {
                          setState(() {
                            pickedDate = DateFormat('d MMMM').format(value);
                          });
                          context.read<CardScreenCubit>().confirmOrder(value);
                        }
                      },
                    );
                  } else if (index == 0) {
                    context
                        .read<CardScreenCubit>()
                        .confirmOrder(DateTime.now());
                  } else {
                    context.read<CardScreenCubit>().confirmOrder(
                        DateTime.now().add(const Duration(days: 1)));
                  }
                },
              );
            }),
          ),
          const SizedBox(height: 35),
          // Example list of times
          Text(
            'Delivery time',
            style: TextStyles.font18BlackBold(context),
          ),
          heightSpace(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              2,
              (index) {
                return ChoiceChip(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  selectedColor: AppColors.primary,
                  checkmarkColor: AppColors.whiteColor,
                  backgroundColor: AppColors.whiteColor,
                  labelStyle: TextStyle(
                      color: index == selectedTimeIndex
                          ? AppColors.whiteColor
                          : AppColors.blackColor),
                  labelPadding: EdgeInsets.zero,
                  label: Column(
                    children: [
                      const Text('Between'),
                      Text(index == 0 ? '9am : 4pm' : '5pm : 10pm'),
                    ],
                  ),
                  selected: selectedTimeIndex == index,
                  onSelected: (bool selected) {
                    setState(() {
                      selectedTimeIndex = index;
                    });
                  },
                );
              },
            ),
          ),
          heightSpace(30),
          primaryButton(title: 'Confirm', borderRadius: 50, verticalHeight: 15)
              .onTap(() {
            context.pop();
          }),
        ],
      ),
    );
  }

  String getDate(int index) {
    switch (index) {
      case 0:
        return 'Today';
      case 1:
        return 'Tomorrow';
      default:
        return pickedDate == null ? 'Pick' : pickedDate!;
    }
  }
}
