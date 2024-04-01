import 'package:book_shop/services/api_services/dioconsumer.dart';
import 'package:book_shop/services/services_locator.dart';
import 'package:dio/dio.dart';

import '../../core/helper/cache_helper.dart';
import 'end_points.dart';

// class ApiInterceptor extends Interceptor {
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     print('Auth check header ${locator<DioConsumer>(param1: true).isAuth}');
//     options.headers[ApiKey.token] =
//         CacheHelper().getData(key: ApiKey.token) != null
//             ? 'FOODAPI ${CacheHelper().getData(key: ApiKey.token)}'
//             : null;
//
//     super.onRequest(options, handler);
//   }
// }
