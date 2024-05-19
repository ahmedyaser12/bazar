import 'package:book_shop/core/widget/bottom_sheet.dart';
import 'package:book_shop/services/services_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/styles.dart';
import '../../../payment_screen/logic/payment_cubit.dart';
import '../../../payment_screen/ui/payment_screen.dart';

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
                Icons.payment_rounded,
                color: AppColors.primary,
              ),
            ),
            title:  Text('Payment',style: TextStyles.font14BlackSemi(context)),
            subtitle:  Text('Choose your payment',style: TextStyles.font14BlackSemi(context)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              bottomSheet(
                  maxHeight: .4,
                  context,
                  buildBody: BlocProvider.value(
                    value: locator<PaymentCubit>(),
                    child: const PaymentScreen(),
                  ));
            },
          ),
        ],
      ),
    );
  }
}
