part of 'payment_cubit.dart';

@immutable
abstract class PaymentState {}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentSuccess extends PaymentState {
  String token;

  PaymentSuccess(this.token);
}

class PaymentError extends PaymentState {
  final String error;

  PaymentError(this.error);
}
