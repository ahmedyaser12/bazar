import 'package:book_shop/core/utils/colors.dart';
import 'package:book_shop/core/utils/common_functions.dart';
import 'package:book_shop/core/utils/extintions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  int selectedTimeIndex = 0;

  @override
  void initState() {
    context.read<CardScreenCubit>().dateTimeString != null
        ? selectedDateIndex = 2
        : selectedDateIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Example UI for selecting dates
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(3, (index) {
              return Padding(
                padding: EdgeInsets.only(right: index == 2 ? 0 : 10.0),
                child: ChoiceChip(
                  showCheckmark: index == 2 ? false : true,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
                                : context
                                            .read<CardScreenCubit>()
                                            .dateTimeString !=
                                        null
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
                            context.read<CardScreenCubit>().confirmOrder(value);
                          }
                        },
                      );
                    }
                  },
                ),
              );
            }),
          ),
          const SizedBox(height: 35),
          // Example list of times
          Text(
            'Delivery time',
            style: TextStyles.font18BlackBold,
          ),
          heightSpace(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              2,
              (index) {
                return ChoiceChip(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  selectedColor: AppColors.primary,
                  checkmarkColor: AppColors.whiteColor,
                  backgroundColor: AppColors.whiteColor,
                  labelStyle: TextStyle(
                      color: index == selectedTimeIndex
                          ? AppColors.whiteColor
                          : AppColors.blackColor),
                  labelPadding: EdgeInsets.zero,
                  label: const Column(
                    children: [
                      Text('Between'),
                      Text('10pm : 11pm'),
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
        return context.read<CardScreenCubit>().dateTimeString == null
            ? 'Pick'
            : context.read<CardScreenCubit>().dateTimeString!;
    }
  }
}
