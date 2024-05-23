import 'package:book_shop/config/routs/routs_names.dart';
import 'package:book_shop/core/utils/extintions.dart';
import 'package:book_shop/core/utils/styles.dart';
import 'package:book_shop/screens/cart_screen/ui/widget/adress_widget.dart';
import 'package:book_shop/services/services_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/colors.dart';
import '../../../core/widget/app_buttons.dart';
import '../logic/card_screen_cubit.dart';
import 'widget/date_time_widget.dart';
import 'widget/payment_widget.dart';
import 'widget/summary_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: locator<CardScreenCubit>()..getCartDetails(),
      child: const ConfirmOrderScreen(),
    );
  }
}

class ConfirmOrderScreen extends StatelessWidget {
  const ConfirmOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(
          'Confirm Order',
          style: TextStyles.font24BlackBold(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded),
            onPressed: () {
              // TODO: Implement edit action
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const AddressWidget(),
          context.read<CardScreenCubit>().addresses == null
              ? Text(
                  'Please choose Your Location',
                  style: TextStyles.font13grey500weight
                      .copyWith(color: AppColors.redColor),
                )
              : Container(),
          const SizedBox(height: 16),
          const SummaryWidget(),
          const SizedBox(height: 16),
          const DateTimeWidget(),
          context.read<CardScreenCubit>().dateTimeString == null
              ? Text(
                  'Please choose Your Date and Time',
                  style: TextStyles.font13grey500weight
                      .copyWith(color: AppColors.redColor),
                )
              : Container(),
          const SizedBox(height: 16),
          const PaymentWidget(),
          const SizedBox(height: 16),
          primaryButton(title: 'Ordered', borderRadius: 50, verticalHeight: 15)
              .onTap(() {
            if (context.read<CardScreenCubit>().dateTimeString != null &&
                context.read<CardScreenCubit>().addresses != null) {
              context.navigateTo(RouteName.STATUSORDER);
            } else {
              if (context.read<CardScreenCubit>().dateTimeString == null) {
                context.read<CardScreenCubit>().changeIsTimeTaken();
              }
              if (context.read<CardScreenCubit>().addresses == null) {
                context.read<CardScreenCubit>().changeIsLocated();
              }
            }
          })
        ],
      ),
    );
  }
}
