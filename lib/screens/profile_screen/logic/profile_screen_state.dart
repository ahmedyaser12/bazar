part of 'profile_screen_cubit.dart';

@immutable
abstract class ProfileScreenState {}

class ProfileScreenInitial extends ProfileScreenState {}

class UserDetailsSuccess extends ProfileScreenState {
  final UserModel userModel;

  UserDetailsSuccess(this.userModel);
}

class UserDetailsFailure extends ProfileScreenState {
  final String message;

  UserDetailsFailure(this.message);
}
