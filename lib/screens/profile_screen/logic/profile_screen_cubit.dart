import 'package:book_shop/core/chase_helper/cache_helper.dart';
import 'package:book_shop/core/utils/status.dart';
import 'package:book_shop/screens/profile_screen/data/user_model.dart';
import 'package:book_shop/services/api_services/end_points.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../services/api_services/api_service.dart';

part 'profile_screen_state.dart';

class ProfileScreenCubit extends Cubit<ProfileScreenState> {
  final ApiService apiService;

  ProfileScreenCubit(this.apiService) : super(ProfileScreenInitial());

  UserModel? userModel;

  void getUser() async {
    var response =
        await apiService.getUser(id: CacheHelper().getData(key: ApiKey.id));
    print("id${CacheHelper().getData(key: ApiKey.id)}");
    if (response.status == Status.SUCCESS) {
      userModel = response.data;
      emit(UserDetailsSuccess(userModel!));
    } else {
      emit(UserDetailsFailure(response.errorMessage!));
    }
  }
}
