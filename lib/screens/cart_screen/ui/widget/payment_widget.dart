import 'package:flutter/material.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/styles.dart';
class PaymentWidget extends StatelessWidget {
  const PaymentWidget({super.key});

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
            'Payment:',
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
                Icons.payment_rounded,
                color: AppColors.primary,
              ),
            ),
            title: const Text('Payment'),
            subtitle: const Text('Choose your payment'),
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
