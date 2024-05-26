import 'package:book_shop/services/firebase_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/status.dart';
import '../../../services/api_services/api_service.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final ApiService apiService;
  final FirebaseService firebaseService;

  PaymentCubit(this.apiService, this.firebaseService) : super(PaymentInitial());

  bool isPayment = true;
  String? paymentName;

  Future<String?> getPaymentKey(int amount, String currency) async {
    try {
      String authenticationToken = await _getAuthenticationToken();

      int? orderId = await _getOrderId(
        authenticationToken: authenticationToken,
        amount: (100 * amount).toString() + 2.toString(),
        currency: currency,
      );
      String? paymentKey = await _getPaymentKey(
        authenticationToken: authenticationToken,
        amount: (100 * amount).toString(),
        currency: currency,
        orderId: orderId.toString(),
      );
      emit(PaymentSuccess(paymentKey!));
      print('i\'m here');
    } catch (e) {
      print("Exc==========================================");
      print(e.toString());
      emit(PaymentError(e.toString()));
    }
    return null;
  }

  Future<String> _getAuthenticationToken() async {
    final response = await apiService.getAuthToken();
    if (response.status == Status.SUCCESS) {
      print("this is AuthToken:${response.data}");
      return response.data!;
    } else {
      emit(PaymentError(response.errorMessage.toString()));
    }
    return "";
  }

  Future<int?> _getOrderId(
      {required String authenticationToken,
      required String amount,
      required String currency}) async {
    final response = await apiService.getOrderId(
        authenticationToken: authenticationToken,
        amount: amount,
        currency: currency);
    if (response.status == Status.SUCCESS) {
      print("this is id:${response.data}");
      return int.parse(response.data!);
    } else {
      emit(PaymentError(response.errorMessage.toString()));
    }
    return null;
  }

  Future<String?> _getPaymentKey(
      {required String authenticationToken,
      required String amount,
      required String currency,
      required String orderId}) async {
    final response = await apiService.getPaymentToken(
        currency: currency,
        amount: amount,
        orderId: orderId,
        authenticationToken: authenticationToken);
    if (response.status == Status.SUCCESS) {
      print("this is Token:${response.data}");
      return response.data;
    } else {
      emit(PaymentError(response.errorMessage.toString()));
    }
    return '';
  }

  void changeIsPayment(bool value) {
    isPayment = value;
    emit(ChangeIsPayment());
  }
}
