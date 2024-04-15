import 'package:book_shop/screens/search_screen/data/model.dart';
import 'package:book_shop/services/api_services/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/status.dart';

part 'search_screen_state.dart';

class SearchCubit extends Cubit<SearchScreenState> {
  SearchCubit(this.apiService) : super(SearchScreenInitial());
  final ApiService apiService;
  var searchController = TextEditingController();

  List<SearchModel> bookSearch = [];

  void getSearchBook() async {
    emit(LoadingList());
    final response = await apiService.searchBook(searchController.text);
    if (response.status == Status.SUCCESS) {
      bookSearch = response.data!;
      emit(ListSearchLoaded(bookSearch));
      print('success');
    } else if (response.status == Status.ERROR) {
      emit(FailureRequest(response.errorMessage!));
    }
  }
}
