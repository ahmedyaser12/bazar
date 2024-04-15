import 'package:book_shop/core/utils/extintions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/common_functions.dart';
import '../../../../core/utils/styles.dart';
import '../../logic/card_screen_cubit.dart';

class CartDetails extends StatelessWidget {
  List cartList;
  int totalPrice;
  final void Function(int index) onTab;

  CartDetails(
      {super.key,
      required this.cartList,
      required this.totalPrice,
      required this.onTab});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardScreenCubit, CardScreenState>(
      builder: (context, state) {
        if (state is RemoveItem) {
          cartList = state.cartList;
          totalPrice = state.totalPrice;
          return cartList.isNotEmpty
              ? Column(
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
                                      Container(
                                        constraints:
                                            const BoxConstraints(maxWidth: 200),
                                        child: Text(
                                          cartList[index]['name'],
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      cartList[index]['num'] != 1
                                          ? Text(
                                              "  \(${cartList[index]['num'].toString()}\)")
                                          : Container(),
                                      widthSpace(
                                          cartList[index]['num'] != 1 ? 5 : 0),
                                    ],
                                  ),
                                  trailing: Text(
                                    '\$${cartList[index]['price'].toString()}',
                                    style: TextStyles.font14BlackSemi,
                                  ).onTap(() {
                                    onTab(index);
                                  }),
                                ),
                              ),
                            ),
                          ),
                          const Divider(),
                          heightSpace(8.0),
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
                )
              : const Center(
                  child: Text('Cart is empty'),
                );
        }
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
                  cartList.isNotEmpty
                      ? Column(
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
                                    Container(
                                      constraints:
                                          const BoxConstraints(maxWidth: 200),
                                      child: Text(
                                        cartList[index]['name'],
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    cartList[index]['num'] != 1
                                        ? Text(
                                            "  \(${cartList[index]['num'].toString()}\)")
                                        : Container(),
                                    widthSpace(
                                        cartList[index]['num'] != 1 ? 5 : 0),
                                  ],
                                ),
                                trailing: Text(
                                  '\$${cartList[index]['price'].toString()}',
                                  style: TextStyles.font14BlackSemi,
                                ).onTap(() {
                                  onTab(index);
                                }),
                              ),
                            ),
                          ),
                        )
                      : Center(
                          child: Column(
                            children: [
                              Text(
                                'Cart is empty',
                                style: TextStyles.font18BlackBold,
                              ),
                              Center(
                                child:
                                    SvgPicture.asset('assets/svgs/Group.svg'),
                              ),
                            ],
                          ),
                        ),
                  const Divider(),
                  heightSpace(8.0),
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
      },
    );
  }
}
