part of 'search_screen_cubit.dart';

@immutable
abstract class SearchScreenState {}

class SearchScreenInitial extends SearchScreenState {}

class LoadingList extends SearchScreenState {}

class ListSearchLoaded extends SearchScreenState {
  final List<SearchModel> searchBook;

  ListSearchLoaded(this.searchBook);
}

class FailureRequest extends SearchScreenState {
  final String error;

  FailureRequest(this.error);
}
