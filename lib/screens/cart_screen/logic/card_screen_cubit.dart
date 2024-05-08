import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../core/helper/cache_helper.dart';
import '../../../services/api_services/end_points.dart';
import '../../../services/firebase_service.dart';

part 'card_screen_state.dart';

class CardScreenCubit extends Cubit<CardScreenState> {
  CardScreenCubit(this.firebaseService) : super(CardScreenInitial());
  final FirebaseService firebaseService;
  int numberCount = 0;
  String? dateTimeString;
  DateTime? dateTime;
  List cartList = [];

  void getCartDetails() async {
    emit(CartLoading());
    final userId = CacheHelper().getData(key: ApiKey.id);
    final response = await firebaseService.getCartItems(userId);
    cartList = response;
    emit(GetCart(response));
  }

  getTotalPrice(List cartDetails) {
    int total = 0;
    for (var cart in cartDetails) {
      if (cart['price'] != null) {
        total += cart['price'] * cart['num'] as int;
      }
    }
    CacheHelper().saveData(key: 'total price', value: total);
    return total;
  }

  removeItem(int id) async {
    List<dynamic> cartList = await firebaseService.removeFromCart(
        CacheHelper().getData(key: ApiKey.id), id);
    print('done');
    int totalPrice = getTotalPrice(cartList);
    emit(RemoveItem(cartList, totalPrice));
  }

  updateNumberOfItems(int id, int num) async {
    List<dynamic> cartDetails = await firebaseService.updateNumberOfItems(
        CacheHelper().getData(key: ApiKey.id), id, num);
    int totalPrice = getTotalPrice(cartList);

    emit(UpdateNumberOfItems(totalPrice));
  }

  String switchFromDateDayToHisName(int day, int month) {
    switch (month) {
      case DateTime.january:
        {
          return '$day January';
        }
      case DateTime.february:
        {
          return '$day February';
        }
      case DateTime.march:
        {
          return '$day March';
        }
      case DateTime.april:
        {
          return '$day April';
        }
      case DateTime.may:
        {
          return '$day May';
        }
      case DateTime.june:
        {
          return '$day June';
        }
      case DateTime.july:
        {
          return '$day July';
        }
      case DateTime.august:
        {
          return '$day August';
        }
      case DateTime.september:
        {
          return '$day September';
        }
      case DateTime.october:
        {
          return '$day October';
        }
      case DateTime.november:
        {
          return '$day November';
        }
      case DateTime.december:
        {
          return '$day December';
        }
      default:
        {
          return 'Invalid date';
        }
    }
  }

  String formatDateTime(DateTime dateTime) {
    return DateFormat('d MMMM').format(dateTime);
  }

  void confirmOrder(DateTime dateTime) {
    dateTimeString = formatDateTime(dateTime);
    this.dateTime = dateTime;
    emit(ConfirmOrder(dateTime));
  }
}
