part of 'profile_screen_cubit.dart';

@immutable
abstract class ProfileScreenState {}

class ProfileScreenInitial extends ProfileScreenState {}

class LoadingUser extends ProfileScreenState {}

class UserDetailsSuccess extends ProfileScreenState {
  final UserModel userModel;

  UserDetailsSuccess(this.userModel);
}

class UserDetailsFailure extends ProfileScreenState {
  final String message;

  UserDetailsFailure(this.message);
}

class PickImage extends ProfileScreenState {}

class UpdateLoading extends ProfileScreenState {}

class UpdateSuccess extends ProfileScreenState {
  final String success;

  UpdateSuccess(this.success);
}

class UpdateFailure extends ProfileScreenState {
  final String error;

  UpdateFailure(this.error);
}
