import 'package:book_shop/screens/status_order_screen/logic/status_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/colors.dart';

class StatusOrder extends StatelessWidget {
  const StatusOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50], // Background color of the screen
      body: Center(
        child: BlocConsumer<StatusScreenCubit, StatusScreenState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is StatusScreenLoaded) {
              final order = state.response;
              return Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: AppColors.greyColor,
                    ),
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(12)),
                margin: const EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Column(
                          children: List.generate(
                        order['cartItems'].length,
                        (index) => ListTile(
                          title: Text(order['cartItems'][index]['name'],
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          trailing: Text(
                              '\$${order['cartItems'][index]['price'] * order['cartItems'][index]['num']}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 13)),
                          leading: Text(
                            order['cartItems'][index]['num'].toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                        ),
                      )),
                      const Divider(),
                      _buildSummaryLine('Subtotal', '\$${order['totalPrice']}'),
                      _buildSummaryLine('Shipping', '\$2.00'),
                      const Divider(),
                      _buildSummaryLine(
                          'Total Payment', '\$${order['totalPrice'] + 2.00}',
                          isTotal: true),
                      _buildSummaryLine(
                        'Delivery in',
                        "(${context.read<StatusScreenCubit>().getDayLeft(order)}Left)  ${order['deliveryDate']}",
                      ),
                    ],
                  ),
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSummaryLine(String leading, String trailing,
      {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(leading,
              style: TextStyle(
                  fontSize: isTotal ? 18 : 15,
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                  color: AppColors.blackColor)),
          Text(trailing,
              style: TextStyle(
                  fontSize: isTotal ? 18 : 15,
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                  color: isTotal ? AppColors.primary : AppColors.blackColor)),
        ],
      ),
    );
  }
}
