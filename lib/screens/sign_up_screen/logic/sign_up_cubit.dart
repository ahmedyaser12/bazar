import 'package:book_shop/core/utils/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../services/api_services/api_service.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final ApiService apiService;

  TextEditingController nameController;
  TextEditingController phoneController;
  TextEditingController emailController;
  TextEditingController passwordController;
  TextEditingController confirmController;

  final formKey = GlobalKey<FormState>();
  XFile? pickImage;

  SignUpCubit(this.apiService)
      : nameController = TextEditingController(),
        phoneController = TextEditingController(),
        emailController = TextEditingController(),
        passwordController = TextEditingController(),
        confirmController = TextEditingController(),
        super(SignUpInitial());

  void reinitializeControllers() {
    nameController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmController = TextEditingController();
  }

  void disposeControllers() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    print('dispose1');
  }

  void uploadProfilePic(XFile? image) {
    pickImage = image;
    emit(PickImage());
  }

  void signUp() async {
    if (!formKey.currentState!.validate()) return;

    emit(SignUpLoading());
    var response = await apiService.signUp(
      name: nameController.text,
      email: emailController.text,
      phone: phoneController.text,
      password: passwordController.text,
      confirmPassword: confirmController.text,
      profilePic: pickImage!,
    );
    if (response.status == Status.SUCCESS) {
      emit(SignUpSuccess(response.data!.message!));
    } else {
      emit(SignUpFailure((response.errorList == null
          ? response.errorMessage
          : response.errorList?[0] + response.errorMessage ??
              "An unknown error occurred")));
    }
  }

  @override
  Future<void> close() {
    disposeControllers();
    print('dispose2');
    return super.close();
  }
}
