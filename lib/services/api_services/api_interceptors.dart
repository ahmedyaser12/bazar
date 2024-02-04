import 'package:dio/dio.dart';

import '../../core/utils/constant.dart';
import 'end_points.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers = {
      'X-RapidAPI-Key': EndPoints.apiKey,
      'X-RapidAPI-Host': EndPoints.apiHost
    };
    super.onRequest(options, handler);
  }
}
