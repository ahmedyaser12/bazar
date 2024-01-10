import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../services/firebase_service.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final FirebaseService _firebaseServices;

  SignUpCubit(this._firebaseServices, this.firebaseAuth)
      : super(SignUpInitial());
  final FirebaseAuth firebaseAuth;
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void signUp() async {
    try {
      emit(SignUpLoading());
      UserCredential userCredential = await _firebaseServices.signUp(
          emailController.text, passwordController.text);
      emit(SignUpSuccess(userCredential.user!));
      print('success');
    } on FirebaseAuthException catch (e) {
      emit(SignUpFailure(e.message ?? "An unknown error occurred"));
    }
  }

  String getEmail() {
    print('inCubit${emailController.text}');
    return emailController.text;
  }
}
