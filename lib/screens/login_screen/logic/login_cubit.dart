import 'package:book_shop/services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final FirebaseService _firebaseServices;

  LoginCubit(this._firebaseServices, this._firebaseAuth)
      : super(LoginInitial());
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool isSecure = true;
  final FirebaseAuth _firebaseAuth;
  final formKey = GlobalKey<FormState>();

  void isSecures() {
    isSecure = !isSecure;
    emit(IsSecure());
  }

  Future login() async {
    try {
      emit(LoginLoading());
      UserCredential userCredential = await _firebaseServices.signIn(
          emailController.text, passwordController.text);
      emit(LoginSuccess(userCredential.user!));
      print('success');
    } on FirebaseAuthException catch (e) {
      emit(LoginFailure(e.message ?? "An unknown error occurred"));
    }
  }

  void signOut() async {
    await _firebaseAuth.signOut();
    emit(Unauthenticated());
  }
}
