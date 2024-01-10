import 'package:book_shop/screens/home/data/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/status.dart';
import '../../../services/api_service.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ApiService apiService;

  HomeCubit(this.apiService) : super(HomeInitial());
  int currentSwiperIndex = 0;
  List<TopWeakModel> getTopWeak = [];

  void currentSwiperNum(int index) {
    currentSwiperIndex = index;
    emit(SwiperNumber());
  }

  void getTopWeakBook() async {
    emit(LoadingList());
    final response = await apiService.getTopWeaklyBook();
    if (response.status == Status.SUCCESS) {
      getTopWeak = response.data!;
      emit(ListTopWeakLoaded(getTopWeak));
      print('success');
    }
  }
}
