import 'package:book_shop/core/utils/extintions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/common_functions.dart';
import '../../../../core/utils/styles.dart';
import '../../logic/card_screen_cubit.dart';

class CartDetails extends StatefulWidget {
  List cartList;
  int totalPrice;
  final void Function(int index) onTab;

  CartDetails(
      {super.key,
      required this.cartList,
      required this.totalPrice,
      required this.onTab});

  @override
  State<CartDetails> createState() => _CartDetailsState();
}

class _CartDetailsState extends State<CartDetails> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardScreenCubit, CardScreenState>(
      builder: (context, state) {
        if (state is RemoveItem) {
          widget.cartList = state.cartList;
          widget.totalPrice = state.totalPrice;
        }
        if (state is UpdateNumberOfItems) {
          widget.totalPrice = state.totalPrice;
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cart Details',
              style: TextStyles.font18BlackBold(context),
            ),
            heightSpace(10),
            widget.cartList.isNotEmpty
                ? Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.greyColor,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Column(
                          children:
                              List.generate(widget.cartList.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: ListTile(
                                horizontalTitleGap: 5,
                                contentPadding: EdgeInsets.zero,
                                leading: Image.network(
                                  widget.cartList[index]['cover'],
                                  width: 40,
                                ),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      constraints: BoxConstraints(
                                          maxWidth: MediaQuery.of(context)
                                                      .size
                                                      .width >
                                                  600
                                              ? 150
                                              : 90,
                                          minWidth: MediaQuery.of(context)
                                                      .size
                                                      .width >
                                                  600
                                              ? 150
                                              : 90),
                                      child: Text(
                                        widget.cartList[index]['name'],
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyles.font14BlackSemi(context)
                                            .copyWith(fontSize: 12),
                                      ),
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                           Icon(
                                                  Icons.remove_circle_outline,color: Theme.of(context).brightness ==
                                          Brightness.dark
                                          ? AppColors.whiteColor
                                          :AppColors.darkBlue,)
                                              .onTap(() {
                                            if (widget.cartList[index]['num'] >
                                                1) {
                                              int newNum = widget
                                                      .cartList[index]['num'] -
                                                  1; // Pre-decrement
                                              context
                                                  .read<CardScreenCubit>()
                                                  .updateNumberOfItems(
                                                      widget.cartList[index]
                                                          ['id'],
                                                      newNum);
                                              setState(() {
                                                widget.cartList[index]['num'] =
                                                    newNum; // Update state to newNum after BLoC
                                              });
                                            }
                                          }),
                                          widthSpace(3),
                                          Text(widget.cartList[index]['num']
                                              .toString(),style: TextStyles.font14BlackSemi(context),),
                                          widthSpace(3),
                                           Icon(Icons.add_circle_outline,color:Theme.of(context).brightness ==
                                          Brightness.dark
                                          ? AppColors.whiteColor
                                          :AppColors.darkBlue,)
                                              .onTap(() {
                                            int newNum = widget.cartList[index]
                                                    ['num'] +
                                                1; // Pre-increment
                                            context
                                                .read<CardScreenCubit>()
                                                .updateNumberOfItems(
                                                    widget.cartList[index]
                                                        ['id'],
                                                    newNum);
                                            setState(() {
                                              widget.cartList[index]['num'] =
                                                  newNum; // Update state to newNum after BLoC
                                            });
                                          }),
                                        ]),
                                    Row(
                                      children: [
                                        Text(
                                          '\$${(widget.cartList[index]['price'] * widget.cartList[index]['num']).toString()}',
                                          style: TextStyles.font14BlackSemi(context),
                                        ),
                                        widthSpace(5),
                                        Icon(
                                          Icons.delete,
                                          color: AppColors.redColor,
                                        ).onTap(() {
                                          widget.onTab(index);
                                        })
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                        const Divider(),
                        heightSpace(8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                           Text(
                              'Total Price',
                              style: TextStyles.font18BlackBold(context),
                            ),
                            Text(
                              '\$${widget.totalPrice.toString()}',
                              style: TextStyles.font18BlackBold(context),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      heightSpace(50.0),
                      Center(child: SvgPicture.asset('assets/svgs/Group.svg')),
                      heightSpace(20.0),
                      Text(
                        'There is no product in cart',
                        style: TextStyles.font18BlackBold(context),
                      ),
                    ],
                  ),
          ],
        );
      },
    );
  }
}
