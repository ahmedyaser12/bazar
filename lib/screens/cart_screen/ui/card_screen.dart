import 'package:book_shop/config/routs/routs_names.dart';
import 'package:book_shop/core/utils/extintions.dart';
import 'package:book_shop/core/utils/styles.dart';
import 'package:book_shop/screens/cart_screen/ui/widget/adress_widget.dart';
import 'package:book_shop/screens/payment_screen/logic/payment_cubit.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: locator<CardScreenCubit>()..getCartDetails(),
        ),
        BlocProvider.value(
          value: locator<PaymentCubit>(),
        )
      ],
      child: const ConfirmOrderScreen(),
    );
  }
}

class ConfirmOrderScreen extends StatefulWidget {
  const ConfirmOrderScreen({super.key});

  @override
  ConfirmOrderScreenState createState() => ConfirmOrderScreenState();
}

class ConfirmOrderScreenState extends State<ConfirmOrderScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<Widget> _widgets = [
    const AddressWidget(),
    const SummaryWidget(),
    const DateTimeWidget(),
    const PaymentWidget(),
  ];

  // Flag to track if the animation has been shown

  @override
  void initState() {
    super.initState();
    print('initState ${context.read<CardScreenCubit>().hasShownAnimation}');
    // Use a post frame callback to start the animation after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) => _startAnimation());
  }

  void _startAnimation() async {
    // Start the animation only if it hasn't been shown yet
    if (!context.read<CardScreenCubit>().hasShownAnimation) {
      print('in if ${context.read<CardScreenCubit>().hasShownAnimation}');
      for (int i = 0; i < _widgets.length; i++) {
        await Future.delayed(const Duration(milliseconds: 300));
        _listKey.currentState?.insertItem(i);
      }
      print('out if ${context.read<CardScreenCubit>().hasShownAnimation}');
      // Set the flag to true after showing the animation
      context.read<CardScreenCubit>().hasShownAnimation = true;
      print('change ${context.read<CardScreenCubit>().hasShownAnimation}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(
          'Confirm Order',
          style: TextStyles.font18BlackBold(context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications_none_rounded,
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.whiteColor
                  : AppColors.blackColor,
            ),
            onPressed: () {
              // TODO: Implement edit action
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Flexible(
              child: AnimatedList(
                key: _listKey,
                initialItemCount:
                    context.read<CardScreenCubit>().hasShownAnimation
                        ? _widgets.length
                        : 0,
                itemBuilder: (context, index, animation) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(1, 0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: _widgets[index],
                    ),
                  );
                },
              ),
            ),
            primaryButton(
              title: 'Ordered',
              borderRadius: 50,
              verticalHeight: 15,
            ).onTap(() {
              print(context.read<PaymentCubit>().paymentName);

              if (context.read<CardScreenCubit>().dateTimeString != null &&
                  context.read<CardScreenCubit>().addresses != null &&
                  context.read<PaymentCubit>().paymentName != null &&
                  context.read<CardScreenCubit>().cartList.isNotEmpty) {
                context.navigateTo(RouteName.STATUSORDER);
                context.read<CardScreenCubit>().addDeliveryTimeAndLocation();
              } else {
                if (context.read<CardScreenCubit>().dateTimeString == null) {
                  context.read<CardScreenCubit>().changeIsTimeTaken();
                }
                if (context.read<CardScreenCubit>().addresses == null) {
                  context.read<CardScreenCubit>().changeIsLocated();
                }
                if (context.read<PaymentCubit>().paymentName == null) {
                  context.read<PaymentCubit>().changeIsPayment(false);
                }
                if (context.read<CardScreenCubit>().cartList.isEmpty) {
                  context.read<CardScreenCubit>().listIsEmpty();
                } else {
                  context.read<CardScreenCubit>().listIsEmpty();
                }
              }
            }),
          ],
        ),
      ),
    );
  }
}
