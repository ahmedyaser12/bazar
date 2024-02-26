import 'package:book_shop/services/api_services/dioconsumer.dart';
import 'package:book_shop/services/services_locator.dart';
import 'package:dio/dio.dart';

import '../../core/chase_helper/cache_helper.dart';
import 'end_points.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers = {
      locator<DioConsumer>().isAuth == false
              ? 'X-RapidAPI-Key'
              : EndPoints.apiKey:
          CacheHelper().getData(key: ApiKey.token) != null
              ? 'FOODAPI ${CacheHelper().getData(key: ApiKey.token)}'
              : null,
    };
    super.onRequest(options, handler);
  }
}
