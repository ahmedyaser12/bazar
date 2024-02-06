part of 'author_details_cubit.dart';

@immutable
abstract class AuthorDetailsState {}

class AuthorDetailsInitial extends AuthorDetailsState {}

class DetailsLoading extends AuthorDetailsState {}

class DetailsLoaded extends AuthorDetailsState {
  final AuthorDetailsModel authorDetails;

  DetailsLoaded(this.authorDetails);
}

class Failure extends AuthorDetailsState {
  Failure(String s);
}
