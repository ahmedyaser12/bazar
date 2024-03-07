import 'package:flutter/material.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/styles.dart';
class DateTimeWidget extends StatelessWidget {
  const DateTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.greyColor, width: 1),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Date and time:',
            style: TextStyles.font18BlackBold,
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
            title: const Text('Date & time'),
            subtitle: const Text('Choose date and time'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: Implement date and time picker
            },
          ),
        ],
      ),
    );
  }
}
