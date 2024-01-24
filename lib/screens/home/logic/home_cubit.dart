import 'package:book_shop/screens/home/data/top_author_model.dart';
import 'package:book_shop/screens/home/data/top_book_of_weak_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/status.dart';
import '../../../services/api_service.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ApiService apiService;

  HomeCubit(this.apiService) : super(HomeInitial());
  int currentSwiperIndex = 0;
  List<TopWeakModel> topBookWeak = [];
  List<TopAuthorsModel> topAuthors = [];

  void currentSwiperNum(int index) {
    currentSwiperIndex = index;
    emit(SwiperNumber());
  }

  void getTopWeakBook() async {
    emit(LoadingList());
    final response = await apiService.getTopWeaklyBook();
    await getTopAuthors();
    if (response.status == Status.SUCCESS) {
      topBookWeak = response.data!;
      emit(ListTopWeakLoaded(topBookWeak, topAuthors));
      print('success');
    } else if (response.status == Status.ERROR) {
      emit(FailureRequest(response.errorMessage!));
    }
  }

  Future getTopAuthors() async {
    final response = await apiService.getTopAuthors();
    if (response.status == Status.SUCCESS) {
      topAuthors = response.data!;
    }
  }
}
