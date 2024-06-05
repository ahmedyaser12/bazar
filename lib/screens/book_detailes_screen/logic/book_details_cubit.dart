import 'package:book_shop/screens/book_detailes_screen/data/model.dart';
import 'package:book_shop/services/api_services/end_points.dart';
import 'package:book_shop/services/firebase_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/helper/cache_helper.dart';
import '../../../core/utils/status.dart';
import '../../../services/api_services/api_service.dart';

part 'book_details_state.dart';

class BookDetailsCubit extends Cubit<BookDetailsState> {
  final ApiService apiService;
  final FirebaseService firebaseService;

  BookDetailsCubit(this.apiService, this.firebaseService)
      : super(BookDetailsInitial());
  BookDetailsModel? bookDetails;
  int? bookId;
  late int productCounter;
  bool isExist = false;
  int counter = 1;

  void getBookDetailed(int id) async {
    emit(DetailsLoading());
    final response = await apiService.getBookDetails(id);
    if (response.status == Status.SUCCESS) {
      print('idbookcubit$bookId');
      bookDetails = response.data;
      emit(DetailsLoaded(bookDetails!));
      checkBookIsExist();
      print('success');
    } else if (response.status == Status.ERROR) {
      emit(Failure(response.errorMessage!));
    }
  }

  counterPlus() {
    counter++;
    print(counter);
    emit(GetCounterNumber());
  }

  counterMinus() {
    if (counter <= 1) {
      return;
    }
    counter--;
    print(counter);
    emit(GetCounterNumber());
  }

  void addToCard() async {
    emit(AddToCard());
    try {
      await firebaseService.addToCart(CacheHelper().getData(key: ApiKey.id), {
        'id': bookDetails!.id,
        'num': counter,
        'name': bookDetails!.name,
        'price': int.parse(bookDetails!.id.toString().substring(0, 2)),
        'cover': bookDetails!.image,
      });
      print('added');
      isExist = true;
      emit(AddedSuccess());
    } catch (e) {
      print("Error adding document: $e");
    }
  }

  List<Map<String, dynamic>> cartItems = [];

  Future<void> getCartItems() async {
    cartItems = await firebaseService
        .getCartItems(CacheHelper().getData(key: ApiKey.id));
  }

  Future<bool> checkBookIsExist() async {
    await getCartItems();
    bool isAdded = cartItems.any((element) => element['id'] == bookDetails!.id);
    isExist = isAdded;
    isAdded ? emit(AddedSuccess()) : emit(BookDetailsInitial());
    return isAdded;
  }

  getProductCounterNumber() {
    // Filter the cartItems to find the one matching the book ID
    var matchingItems = cartItems
        .where((element) => element['id'] == bookDetails!.id)
        .map((e) => e['num']);

    // Check if there are any matching items
    if (matchingItems.isNotEmpty) {
      var matchingItem = matchingItems.first;
      counter = matchingItem;
      emit(GetCounterNumber());
      return matchingItem;
    } else {
      counter = 1;
      emit(GetCounterNumber());
      return 1;
    }
  }
}
