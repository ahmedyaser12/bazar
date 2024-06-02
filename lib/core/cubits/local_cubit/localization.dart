import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(const Locale('en', 'US'));

  void toggleLocale() {
    if (state.languageCode == 'en') {
      emit(const Locale('ar', 'SA'));
    } else {
      emit(const Locale('en', 'US'));
    }
  }
}
