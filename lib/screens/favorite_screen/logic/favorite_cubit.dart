import 'package:book_shop/screens/model/base_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());
  List<BaseModel> favoriteList = [];

  void addFavorite(BaseModel list) {
    favoriteList.add(list);
    emit(GetFavoriteList(favoriteList: favoriteList));
    print(favoriteList);
  }

  deleteFavorite(BaseModel list) {
    favoriteList.remove(list);
    emit(GetFavoriteList(favoriteList: favoriteList));
    print(favoriteList);
  }

  bool isFavorite(BaseModel book) {
    return favoriteList.any((b) => b.id == book.id);
  }
}
