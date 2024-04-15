import 'package:book_shop/core/utils/extintions.dart';
import 'package:flutter/material.dart';

import '../../../../config/routs/routs_names.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/styles.dart';

class AddressWidget extends StatelessWidget {
  const AddressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: AppColors.greyColor,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Address:',
              style: TextStyles.font18BlackBold,
            ),
            const SizedBox(height: 8.0),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(40)),
                    color: AppColors.secondary),
                child: Icon(
                  Icons.location_on_rounded,
                  color: AppColors.primary,
                ),
              ),
              title: const Text(
                'Utama Street No.20',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text(
                  'Dumbo Street No.20, Dumbo,\nNew York 10001, United States'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                context.navigateTo(RouteName.MAP);
              },
            ),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  // TODO: Implement change address action
                },
                child: Text(
                  'Change',
                  style: TextStyle(color: AppColors.primary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
