part of 'book_details_cubit.dart';

@immutable
abstract class BookDetailsState {}

class BookDetailsInitial extends BookDetailsState {}

class DetailsLoading extends BookDetailsState {}

class AddToCard extends BookDetailsState {
  final bool? isAdded;

  AddToCard(this.isAdded);
}

class AddedSuccess extends BookDetailsState {
}

class DetailsLoaded extends BookDetailsState {
  final BookDetailsModel bookDetails;

  DetailsLoaded(this.bookDetails);
}

class GetId extends BookDetailsState {
  final int id;

  GetId(this.id);
}

class Failure extends BookDetailsState {
  Failure(String s);
}
