import 'package:book_shop/core/utils/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../core/chase_helper/cache_helper.dart';
import '../../../services/api_services/api_service.dart';
import '../../../services/api_services/end_points.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final ApiService apiServices;

  LoginCubit(this.apiServices) : super(LoginInitial());
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool isSecure = true;
  final formKey = GlobalKey<FormState>();

  Future login() async {
    emit(LoginLoading());
    // UserCredential userCredential = await _firebaseServices.signIn(
    //     emailController.text, passwordController.text);
    var response = await apiServices.signIn(
        email: emailController.text, password: passwordController.text);
    if (response.status == Status.SUCCESS) {
      final decodedToken = JwtDecoder.decode(response.data!.token);
      CacheHelper().saveData(key: ApiKey.token, value: response.data!.token);
      CacheHelper().saveData(key: 'login', value: true);
      CacheHelper().saveData(key: ApiKey.id, value: decodedToken[ApiKey.id]);
      emit(LoginSuccess(response.data!.message));
      print('success');
    } else {
      emit(LoginFailure(response.errorList == null
          ? response.errorMessage
          : response.errorList?[0] + response.errorMessage ??
              "An unknown error occurred"));
    }
  }

  void signOut() async {
    emit(Unauthenticated());
  }
}
