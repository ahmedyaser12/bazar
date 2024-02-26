part of 'categories_cubit.dart';

@immutable
abstract class CategoriesState {}

class CategoriesInitial extends CategoriesState {}

class LoadingList extends CategoriesState {}

class CategoriesLoaded extends CategoriesState {
  final List<TopWeakModel> categoryList;

  CategoriesLoaded(this.categoryList);
}

class FailureRequest extends CategoriesState {
  final String error;

  FailureRequest(this.error);
}
