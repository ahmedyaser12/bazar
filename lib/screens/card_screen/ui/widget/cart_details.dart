import 'package:flutter/material.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/common_functions.dart';
import '../../../../core/utils/styles.dart';

class CartDetails extends StatelessWidget {
  final List cartList;
  final int totalPrice;

  const CartDetails(
      {super.key, required this.cartList, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cart Details',
          style: TextStyles.font18BlackBold,
        ),
        heightSpace(10),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.greyColor,
              // Color of the border
              width: 1, // Width of the border
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Column(
                children: List.generate(
                  cartList.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Image.network(
                        cartList[index]['cover'],
                        width: 40,
                      ),
                      title: Row(
                        children: [
                          Text(cartList[index]['name']),
                          cartList[index]['num'] != 1
                              ? Text("  \(${cartList[index]['num'].toString()}\)")
                              : Container(),
                          widthSpace(cartList[index]['num'] != 1 ? 5 : 0),
                        ],
                      ),
                      trailing: Text(
                        '\$${cartList[index]['price'].toString()}',
                        style: TextStyles.font14BlackSemi,
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(),
              heightSpace( 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Total Price',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\$${(totalPrice).toString()}',
                    style: TextStyles.font18BlackBold,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
