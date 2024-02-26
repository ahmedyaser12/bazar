part of 'favorite_cubit.dart';

@immutable
abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class GetFavoriteList extends FavoriteState {
  final List<BaseModel> favoriteList;

  GetFavoriteList({required this.favoriteList});
}
