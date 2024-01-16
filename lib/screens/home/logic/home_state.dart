part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class SwiperNumber extends HomeState {}

class LoadingList extends HomeState {}

class ListTopWeakLoaded extends HomeState {
  final List<TopWeakModel> topWeakList;
  final List<TopAuthorsModel> topAuthorsList;

  ListTopWeakLoaded(this.topWeakList, this.topAuthorsList);
}

class FailureRequest extends HomeState {
  final String error;

  FailureRequest(this.error);
}
