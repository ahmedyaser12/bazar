import 'package:book_shop/core/widget/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/styles.dart';
import '../../../../services/services_locator.dart';
import '../../../payment_screen/logic/payment_cubit.dart';
import '../../../payment_screen/ui/payment_screen.dart';

class PaymentWidget extends StatelessWidget {
  const PaymentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentCubit, PaymentState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              decoration: BoxDecoration(
                border: Border.all(
                    color: !context.read<PaymentCubit>().isPayment
                        ? AppColors.redColor
                        : AppColors.greyColor,
                    width: 1),
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
                          borderRadius:
                              const BorderRadius.all(Radius.circular(40)),
                          color: AppColors.secondary),
                      child: Icon(
                        Icons.payment_rounded,
                        color: AppColors.primary,
                      ),
                    ),
                    title: Text('Payment',
                        style: TextStyles.font15BlackMedium(context)),
                    subtitle: Text(
                        context.read<PaymentCubit>().paymentName == null
                            ? 'Choose your payment'
                            : context.read<PaymentCubit>().paymentName!,
                        style: TextStyles.font14BlackSemi(context)
                            .copyWith(fontWeight: FontWeight.normal)),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      bottomSheet(
                          maxHeight: .4,
                          context,
                          buildBody: BlocProvider.value(
                              value: locator<PaymentCubit>(),
                              child: const PaymentScreen()));
                    },
                  ),
                ],
              ),
            ),
            context.read<PaymentCubit>().isPayment == false
                ? Text(
                    'Please choose Your Payment',
                    style: TextStyles.font13grey500weight
                        .copyWith(color: AppColors.redColor, fontSize: 11),
                  )
                : Container(),
          ],
        );
      },
    );
  }
}
