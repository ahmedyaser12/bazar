import 'package:book_shop/core/helper/cache_helper.dart';
import 'package:book_shop/core/utils/common_functions.dart';
import 'package:book_shop/core/utils/extintions.dart';
import 'package:book_shop/core/utils/styles.dart';
import 'package:book_shop/services/firebase_service.dart';
import 'package:book_shop/services/services_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/utils/colors.dart';
import '../../../services/api_services/end_points.dart';
import '../logic/payment_cubit.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your payments:',
          style: TextStyles.font18BlackBold(context).copyWith(fontSize: 25),
        ),
        heightSpace(20),
        BlocConsumer<PaymentCubit, PaymentState>(
          listener: (context, state) {
            if (state is PaymentSuccess) {
              launchUrl(
                Uri.parse(
                    "https://accept.paymob.com/api/acceptance/iframes/833235?payment_token=${state.token}"),
              );
              context.read<PaymentCubit>().paymentName = 'paymob';
              context.read<PaymentCubit>().changeIsPayment(true);
              locator<FirebaseService>().updateCartItem(
                  CacheHelper().getData(key: ApiKey.id), {'Payment': 'Paymob'});
            }
            if (state is PaymentError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                ),
              );
            }
          },
          builder: (context, state) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(6, 50, 143, 1),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: state is! PaymentLoading
                    ? Image.asset(
                        'assets/images/img_3.png',
                        width: double.infinity,
                        height: 100,
                        fit: BoxFit.cover,
                      )
                    : const SizedBox(
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                          ],
                        ),
                      ),
              ).onTap(() {
                context.read<PaymentCubit>().getPaymentKey(
                    CacheHelper().getData(key: 'total price'), 'EGP');
              }),
            );
          },
        ),
        heightSpace(20),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.greyColor, width: 1),
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: BlocBuilder<PaymentCubit, PaymentState>(
            builder: (context, state) {
              return InkWell(
                borderRadius: BorderRadius.circular(30.0),
                child: context.read<PaymentCubit>().paypalLoading
                    ? const SizedBox(
                        height: 85,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                          ],
                        ),
                      )
                    : Image.asset(
                        'assets/images/paypal.png',
                        height: 85,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                onTap: () {
                  print(context.read<PaymentCubit>().paypalLoading);
                  context.read<PaymentCubit>().paypalCheck(true);
                  print(context.read<PaymentCubit>().paypalLoading);
                  Future.delayed(const Duration(seconds: 5), () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => PaypalCheckout(
                          sandboxMode: true,
                          clientId:
                              "AU7y-cFH3X-5kogDUYmJ8ohLCV_y-Rj2QrJCcAX1HjSVQFVzYh0da0VSL6SUK75HkGaX6SmWIIaRqdiQ",
                          secretKey:
                              "ED9Du7Xyu32ryeglWeAg1OlUGv_1m-B9oetVO7SyvXAla80FJ2wX1gjGWfZQAoiXMpk3dx2ZTzkHHRVB",
                          returnURL: "success.snippetcoder.com",
                          cancelURL: "cancel.snippetcoder.com",
                          transactions: const [
                            {
                              "amount": {
                                "total": '70',
                                "currency": "USD",
                                "details": {
                                  "subtotal": '70',
                                  "shipping": '0',
                                  "shipping_discount": 0
                                }
                              },
                              "description":
                                  "The payment transaction description.",
                              // "payment_options": {
                              //   "allowed_payment_method":
                              //       "INSTANT_FUNDING_SOURCE"
                              // },
                              "item_list": {
                                "items": [
                                  {
                                    "name": "Apple",
                                    "quantity": 4,
                                    "price": '5',
                                    "currency": "USD"
                                  },
                                  {
                                    "name": "Pineapple",
                                    "quantity": 5,
                                    "price": '10',
                                    "currency": "USD"
                                  }
                                ],

                                // shipping address is not required though
                                //   "shipping_address": {
                                //     "recipient_name": "Raman Singh",
                                //     "line1": "Delhi",
                                //     "line2": "",
                                //     "city": "Delhi",
                                //     "country_code": "IN",
                                //     "postal_code": "11001",
                                //     "phone": "+00000000",
                                //     "state": "Texas"
                                //  },
                              }
                            }
                          ],
                          note: "Contact us for any questions on your order.",
                          onSuccess: (Map params) async {
                            context.read<PaymentCubit>().paypalCheck(false);

                            print("onSuccess: $params");
                            context.read<PaymentCubit>().paymentName = 'paypal';
                            context.read<PaymentCubit>().changeIsPayment(true);
                            locator<FirebaseService>().updateCartItem(
                                CacheHelper().getData(key: ApiKey.id),
                                {'Payment': 'Paypal'});
                          },
                          onError: (error) {
                            print("onError: $error");
                            Navigator.pop(context);
                          },
                          onCancel: () {
                            print('cancelled:');
                          },
                        ),
                      ),
                    );
                  });
                },
              );
            },
          ),
        )
      ],
    );
  }
}
