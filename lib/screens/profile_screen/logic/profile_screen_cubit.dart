import 'package:book_shop/core/utils/status.dart';
import 'package:book_shop/screens/profile_screen/data/user_model.dart';
import 'package:book_shop/services/api_services/end_points.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/helper/cache_helper.dart';
import '../../../services/api_services/api_service.dart';

part 'profile_screen_state.dart';

class ProfileScreenCubit extends Cubit<ProfileScreenState> {
  final ApiService apiService;

  ProfileScreenCubit(this.apiService) : super(ProfileScreenInitial());
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  UserModel? userModel;
  XFile? updateImage;

  void uploadProfilePic(XFile? image) {
    updateImage = image;
    emit(PickImage());
  }

  void getUser() async {
    emit(LoadingUser());
    var response =
        await apiService.getUser(id: CacheHelper().getData(key: ApiKey.id));
    print("id${CacheHelper().getData(key: ApiKey.id)}");
    if (response.status == Status.SUCCESS) {
      userModel = response.data;
      nameController.text = userModel!.user!.name!;
      phoneController.text = userModel!.user!.phone!;
      print(userModel!.user!.phone!);
      emit(UserDetailsSuccess(userModel!));
    } else {
      emit(UserDetailsFailure(response.errorMessage!));
    }
  }

  Future updateUser() async {
    emit(UpdateLoading());
    var response = await apiService.updateProfile(
        name: nameController.text,
        phone: phoneController.text,
        profilePic: updateImage);
    if (response.status == Status.SUCCESS) {
      emit(UpdateSuccess(response.data!.message!));
    } else {
      UpdateFailure(response.errorMessage!);
    }
  }
}
