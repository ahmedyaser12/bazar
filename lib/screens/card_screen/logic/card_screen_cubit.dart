import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'card_screen_state.dart';

class CardScreenCubit extends Cubit<CardScreenState> {
  CardScreenCubit() : super(CardScreenInitial());
}
