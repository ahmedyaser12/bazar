part of 'status_screen_cubit.dart';

@immutable
abstract class StatusScreenState {}

class StatusScreenInitial extends StatusScreenState {}

class StatusScreenLoading extends StatusScreenState {}

class StatusScreenLoaded extends StatusScreenState {
  final Map<String, dynamic> response;

  StatusScreenLoaded(this.response);
}
