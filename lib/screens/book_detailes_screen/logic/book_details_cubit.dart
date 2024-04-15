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
      print('success');
    } else if (response.status == Status.ERROR) {
      emit(Failure(response.errorMessage!));
    }
  }

  void addToCard(int number) async {
    try {
      await firebaseService.addToCart(CacheHelper().getData(key: ApiKey.id), {
        'id': bookDetails!.id,
        'num': number,
        'name': bookDetails!.name,
        'price': int.parse(bookDetails!.id.toString().substring(0, 2)) * number,
        'cover': bookDetails!.image,
      });
      //     .setDocument('Card', CacheHelper().getData(key: ApiKey.id), {
      //   'id': bookDetails!.id,
      //   'num': number,
      //   'name': bookDetails!.name,
      //   'price': int.parse(bookDetails!.id.toString().substring(0, 2)) * number,
      //   'cover': bookDetails!.image,
      // });
      print('added');
    } catch (e) {
      print("Error adding document: $e");
    }
  }
}
