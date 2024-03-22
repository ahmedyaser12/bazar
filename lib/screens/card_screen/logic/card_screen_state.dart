part of 'card_screen_cubit.dart';

@immutable
abstract class CardScreenState {}

class CardScreenInitial extends CardScreenState {}

class CartLoading extends CardScreenState {}

class ConfirmOrder extends CardScreenState {
  final DateTime dateTime;

  ConfirmOrder(this.dateTime);
}

class AddNum extends CardScreenState {
  final int num;

  AddNum(this.num);
}

class RemoveNum extends CardScreenState {
  final int num;

  RemoveNum(this.num);
}

class GetCart extends CardScreenState {
  final List cartList;

  GetCart(this.cartList);
}
