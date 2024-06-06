import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

import '../../../core/helper/cache_helper.dart';
import '../../../core/helper/location_helper.dart';
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
  Position? position;
  List<geo.Placemark>? addresses;
  bool isLocated = true;
  bool isTimeTaken = true;
  bool isListEmpty = false;
  bool hasShownAnimation = false;

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
    int totalPrice = getTotalPrice(cartList);
    emit(RemoveItem(cartList, totalPrice));
  }

  updateNumberOfItems(int id, int num) async {
    await firebaseService.updateNumberOfItems(
        CacheHelper().getData(key: ApiKey.id), id, num);
    int totalPrice = getTotalPrice(cartList);

    emit(UpdateNumberOfItems(totalPrice));
  }

  addDeliveryTimeAndLocation() {
    firebaseService.updateCartItem(CacheHelper().getData(key: ApiKey.id), {
      'deliveryTime': dateTime,
      'deliveryDate': dateTimeString,
      'totalPrice': getTotalPrice(cartList),
      //'location': addresses![0].toJson(),
    });
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
    isTimeTaken = true;
    emit(ConfirmOrder(dateTime));
  }

  Future<void> getMyCurrentLocation() async {
    position = await LocationHelper.getCurrentLocation();
  }

  Future<dynamic> getLocation() async {
    emit(LocationLoading());
    await getMyCurrentLocation();
    final addresses = await geo.placemarkFromCoordinates(
        position!.latitude, position!.longitude);

    if (addresses.isNotEmpty) {
      this.addresses = addresses;
      isLocated = true;
      emit(GetLocation());
    } else {
      return 'No address available';
    }
  }

  void changeIsTimeTaken() {
    isTimeTaken = false;
    emit(ChangeIsTimeTaken());
  }

  void changeIsLocated() {
    isLocated = false;
    emit(ChangeIsLocated());
  }

  void listIsEmpty() {
    if (cartList.isEmpty) {
      isListEmpty = true;
      print(isListEmpty);
      emit(ChangeListIsEmpty());
    }else{
      isListEmpty = false;
      print(isListEmpty);
      emit(ChangeListIsEmpty());
    }
  }
}
