import 'package:book_shop/core/widget/bottom_sheet.dart';
import 'package:book_shop/screens/cart_screen/logic/card_screen_cubit.dart';
import 'package:book_shop/screens/cart_screen/ui/widget/cart_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/styles.dart';

class SummaryWidget extends StatelessWidget {
  const SummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.greyColor, // Color of the border
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
            style: TextStyles.font18BlackBold,
          ),
          const SizedBox(height: 16.0),
          BlocBuilder<CardScreenCubit, CardScreenState>(
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
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Row(
                          children: [
                            Text(
                              'Price',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Text('\$${totalPrice.toString()}'),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Shipping'),
                        Text('\$2'),
                      ],
                    ),
                    const Divider(),
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text(
                          'Total Payment',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '\$${(totalPrice + 2).toString()}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
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
                        onPressed: () {
                          bottomSheet(
                            context,
                            buildBody: CartDetails(
                              cartList: cartList,
                              totalPrice: totalPrice,
                            ),
                          );
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
                );

              return Container();
            },
          ),
        ],
      ),
    );
  }
}
