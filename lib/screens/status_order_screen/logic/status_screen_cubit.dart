import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/helper/cache_helper.dart';
import '../../../services/api_services/end_points.dart';
import '../../../services/firebase_service.dart';

part 'status_screen_state.dart';

class StatusScreenCubit extends Cubit<StatusScreenState> {
  final FirebaseService firebaseService;

  StatusScreenCubit(this.firebaseService) : super(StatusScreenInitial());

  void getOrders() async {
    emit(StatusScreenLoading());
    final userId = CacheHelper().getData(key: ApiKey.id);
    final response = await firebaseService.getCartItemsToStatusScreen(userId);
    print(response);
    emit(StatusScreenLoaded(response));
  }

  getDayLeft(var order) {
    var orderTime = order['deliveryDate'].substring(0, 3);
    var dateNow = DateTime.now().day;
    final dayLeft = int.parse(orderTime) - dateNow;
    return dayLeft;
  }
}
