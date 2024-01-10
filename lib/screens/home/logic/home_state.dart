part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class SwiperNumber extends HomeState {}

class LoadingList extends HomeState {}

class ListTopWeakLoaded extends HomeState {
  final List<TopWeakModel> topWeakList;

  ListTopWeakLoaded(this.topWeakList);
}
