import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());
  List<dynamic> favoriteList = [];

  void addFavorite(dynamic list) {
    favoriteList.add(list);
  }
}
