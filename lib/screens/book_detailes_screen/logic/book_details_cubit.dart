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

  void addToCard(int number) async {
    emit(AddToCard(true));
    try {
      await firebaseService.addToCart(CacheHelper().getData(key: ApiKey.id), {
        'id': bookDetails!.id,
        'num': number,
        'name': bookDetails!.name,
        'price': int.parse(bookDetails!.id.toString().substring(0, 2)),
        'cover': bookDetails!.image,
      });
      print('added');
      emit(AddedSuccess());
    } catch (e) {
      print("Error adding document: $e");
    }
  }

  List<Map<String, dynamic>> cartItems = [];

  Future<void> getCartItems() async {
    cartItems = await firebaseService
        .getCartItems(CacheHelper().getData(key: ApiKey.id));
    print('cartitems');
  }

  Future<bool> checkBookIsExist() async {
    await getCartItems();
    bool isAdded = cartItems.any((element) => element['id'] == bookDetails!.id);
    print(isAdded);
    isAdded ? emit(AddedSuccess()) : null;
    return isAdded;
  }

  int getProductNumber() {
    // Filter the cartItems to find the one matching the book ID
    var matchingItems = cartItems
        .where((element) => element['id'] == bookDetails!.id)
        .map((e) => e['num']);

    // Check if there are any matching items
    if (matchingItems.isNotEmpty) {
      var matchingItem = matchingItems.first;
      print('this is $matchingItem');
      return matchingItem; // Return the first matching item's 'num' value
    } else {
      // Return a default value if no matching items are found
      print('No matching items found');
      return 1; // or any other default value
    }
  }
}
