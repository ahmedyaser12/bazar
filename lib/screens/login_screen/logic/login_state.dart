part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class IsSecure extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String message;

  LoginSuccess(this.message);
}

class Unauthenticated extends LoginState {}

class LoginFailure extends LoginState {
  final String? error;

  LoginFailure(this.error);
}
