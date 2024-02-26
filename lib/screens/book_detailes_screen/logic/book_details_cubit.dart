import 'package:book_shop/screens/book_detailes_screen/data/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/status.dart';
import '../../../services/api_services/api_service.dart';

part 'book_details_state.dart';

class BookDetailsCubit extends Cubit<BookDetailsState> {
  final ApiService apiService;

  BookDetailsCubit(this.apiService) : super(BookDetailsInitial());
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
}
