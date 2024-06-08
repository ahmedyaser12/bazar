import 'package:book_shop/core/widget/bottom_sheet.dart';
import 'package:book_shop/screens/cart_screen/logic/card_screen_cubit.dart';
import 'package:book_shop/screens/cart_screen/ui/widget/cart_details.dart';
import 'package:book_shop/services/services_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/styles.dart';

class SummaryWidget extends StatelessWidget {
  const SummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardScreenCubit, CardScreenState>(
        buildWhen: (_, state) => state is GetCart || state is ChangeListIsEmpty,
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final cartList = context.read<CardScreenCubit>().cartList;
          final totalPrice =
              context.read<CardScreenCubit>().getTotalPrice(cartList);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: context.read<CardScreenCubit>().isListEmpty==true
                        ? AppColors.redColor
                        : AppColors.greyColor,
                    // Color of the border
                    width: 1, // Width of the border
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Summary',
                      style: TextStyles.font18BlackBold(context),
                    ),
                    const SizedBox(height: 16.0),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: [
                                Text(
                                  'Price',
                                  style: TextStyles.font14BlackSemi(context),
                                ),
                              ],
                            ),
                            Text(
                              '\$${totalPrice.toString()}',
                              style: TextStyles.font14BlackSemi(context),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Shipping',
                              style: TextStyles.font14BlackSemi(context),
                            ),
                            Text(
                              '\$2',
                              style: TextStyles.font14BlackSemi(context),
                            ),
                          ],
                        ),
                        const Divider(),
                        const SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Total Payment',
                              style: TextStyles.font15BlackMedium(context)
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '\$${(totalPrice + 2).toString()}',
                              style: TextStyles.font15BlackMedium(context)
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: AppColors.primary, // Text color
                            ),
                            onPressed: () async {
                              await bottomSheet(
                                context,
                                buildBody: BlocProvider.value(
                                  value: locator<CardScreenCubit>(),
                                  child: CartDetails(
                                    cartList: cartList,
                                    totalPrice: totalPrice,
                                  ),
                                ),
                              );
                              context.read<CardScreenCubit>().getCartDetails();
                            },
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('See details'),
                                Icon(Icons.chevron_right),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              context.read<CardScreenCubit>().isListEmpty == true
                  ? Text(
                      'Please choose Your Location',
                      style: TextStyles.font13grey500weight
                          .copyWith(color: AppColors.redColor, fontSize: 11),
                    )
                  : Container(),
            ],
          );
        });
  }
}
