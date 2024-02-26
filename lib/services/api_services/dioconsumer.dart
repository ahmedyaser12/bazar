import 'package:book_shop/core/errors/exceptions.dart';
import 'package:book_shop/services/api_services/api_consumer.dart';
import 'package:book_shop/services/api_services/api_interceptors.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'end_points.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;
  bool? isAuth;

  DioConsumer({required this.dio, this.isAuth = false}) {
    dio.options.baseUrl = (isAuth! ? EndPoints.authBaseUrl : EndPoints.baseUrl);
    dio.interceptors.add(ApiInterceptor());
    dio.interceptors.add(PrettyDioLogger(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      error: true,
      compact: true,
      maxWidth: 90,
    ));
    dio.options.headers = {
      'X-RapidAPI-Key': EndPoints.apiKey,
      'X-RapidAPI-Host': EndPoints.apiHost
    };
  }

  @override
  Future delete(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameter,
      bool isFormData = false}) async {
    try {
      final response = await dio.delete(path,
          data: isFormData ? FormData.fromMap(data) : data,
          queryParameters: queryParameter);
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  @override
  Future get(String path,
      {Object? data, Map<String, dynamic>? queryParameter}) async {
    try {
      final response =
          await dio.get(path, data: data, queryParameters: queryParameter);
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  @override
  Future patch(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameter,
      bool isFormData = false}) async {
    try {
      final response = await dio.patch(path,
          data: isFormData ? FormData.fromMap(data) : data,
          queryParameters: queryParameter);
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  @override
  Future post(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameter,
      bool isFormData = false}) async {
    try {
      final response = await dio.post(path,
          data: isFormData ? FormData.fromMap(data) : data,
          queryParameters: queryParameter);
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }
}
