import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../services/api_services/api_service.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final ApiService apiService;

  SignUpCubit(this.apiService) : super(SignUpInitial());
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  XFile? pickImage;

  uploadProfilePic(XFile? image) {
    pickImage = image;
    emit(PickImage());
  }

  void signUp() async {
    try {
      emit(SignUpLoading());
      // UserCredential userCredential = await _firebaseServices.signUp(
      //     emailController.text, passwordController.text);
      // _firebaseServices
      //     .getCurrentUser()!
      //     .updateDisplayName(nameController.text);
      await apiService.signUp(
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        password: passwordController.text,
        confirmPassword: confirmController.text,
        profilePic: pickImage!,
      );
      emit(SignUpSuccess());
      print('success');
    } on FirebaseAuthException catch (e) {
      emit(SignUpFailure(e.message ?? "An unknown error occurred"));
    }
  }
}
