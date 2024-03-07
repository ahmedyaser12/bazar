import 'package:book_shop/services/api_services/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/status.dart';
import '../../home/data/top_book_of_weak_model.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit(this.apiService) : super(CategoriesInitial());
  final ApiService apiService;

  List<TopWeakModel> allCategoryList = [];
  List<TopWeakModel> horrorList = [];
  List<TopWeakModel> romanceList = [];
  List<TopWeakModel> actionList = [];
  List<TopWeakModel> scienceList = [];

  void getCategory(String typeOfCategory) async {
    emit(LoadingList());
    final response = await apiService.getCategories(typeOfCategory);
    if (response.status == Status.SUCCESS) {
      switch (typeOfCategory) {
        case 'all':
          allCategoryList = response.data!;
          emit(CategoriesLoaded(allCategoryList));
        case 'horror':
          horrorList = response.data!;
          emit(CategoriesLoaded(horrorList));
        case 'romance':
          romanceList = response.data!;
          emit(CategoriesLoaded(romanceList));
        case 'action':
          actionList = response.data!;
          emit(CategoriesLoaded(actionList));
        case 'science':
          scienceList = response.data!;
          emit(CategoriesLoaded(scienceList));
      }

      print('success');
    } else if (response.status == Status.ERROR) {
      emit(FailureRequest(response.errorMessage!));
    }
  }
}
