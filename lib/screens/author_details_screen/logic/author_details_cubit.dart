import 'package:book_shop/screens/author_details_screen/data/author_model.dart';
import 'package:book_shop/services/api_services/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/status.dart';

part 'author_details_state.dart';

class AuthorDetailsCubit extends Cubit<AuthorDetailsState> {
  AuthorDetailsCubit(this.apiService) : super(AuthorDetailsInitial());
  final ApiService apiService;

  void getAuthorDetailed(int id) async {
    emit(DetailsLoading());
    final response = await apiService.getAuthorDetails(id);
    if (response.status == Status.SUCCESS) {
      AuthorDetailsModel? authorDetails;
      authorDetails = response.data;
      emit(DetailsLoaded(authorDetails!));
      print('success');
    } else if (response.status == Status.ERROR) {
      emit(Failure(response.errorMessage!));
    }
  }
}
