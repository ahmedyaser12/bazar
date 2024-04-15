part of 'sign_up_cubit.dart';

@immutable
abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class PickImage extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {
  final String success;

  SignUpSuccess(this.success);
}

class SignUpFailure extends SignUpState {
  final String error;

  SignUpFailure(this.error);
}
