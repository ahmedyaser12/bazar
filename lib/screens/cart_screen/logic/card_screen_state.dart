part of 'card_screen_cubit.dart';

@immutable
abstract class CardScreenState {}

class CardScreenInitial extends CardScreenState {}

class CartLoading extends CardScreenState {}

class ConfirmOrder extends CardScreenState {
  final DateTime dateTime;

  ConfirmOrder(this.dateTime);
}

class RemoveItem extends CardScreenState {
  final List cartList;
  final int totalPrice;

  RemoveItem(this.cartList, this.totalPrice);
}

class UpdateNumberOfItems extends CardScreenState {
  final int totalPrice;

  UpdateNumberOfItems(this.totalPrice);
}

class AddNum extends CardScreenState {
  final int num;

  AddNum(this.num);
}

class GetCart extends CardScreenState {
  final List cartList;

  GetCart(this.cartList);
}

class LocationLoading extends CardScreenState {
  LocationLoading();
}

class GetLocation extends CardScreenState {
  GetLocation();
}

class ChangeIsTimeTaken extends CardScreenState {}

class ChangeIsLocated extends CardScreenState {}
class ChangeListIsEmpty extends CardScreenState {}

