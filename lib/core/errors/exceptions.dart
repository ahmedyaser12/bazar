import 'package:book_shop/core/errors/error_model.dart';
import 'package:dio/dio.dart';

class ServerExceptions implements Exception {
  final ErrorModel errModel;

  ServerExceptions({required this.errModel});
}

void handleDioExceptions(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      throw ServerExceptions(errModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.sendTimeout:
      throw ServerExceptions(errModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.receiveTimeout:
      throw ServerExceptions(errModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.badCertificate:
      throw ServerExceptions(errModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.badResponse:
      switch (e.response!.statusCode) {
        case 400:
          throw ServerExceptions(
              errModel: ErrorModel.fromJson(e.response!.data));
        case 401:
          throw ServerExceptions(
              errModel: ErrorModel.fromJson(e.response!.data));
        case 403:
          throw ServerExceptions(
              errModel: ErrorModel.fromJson(e.response!.data));
        case 404:
          throw ServerExceptions(
              errModel: ErrorModel.fromJson(e.response!.data));
        case 409:
          throw ServerExceptions(
              errModel: ErrorModel.fromJson(e.response!.data));
        case 422:
          throw ServerExceptions(
              errModel: ErrorModel.fromJson(e.response!.data));
        case 504:
          throw ServerExceptions(
              errModel: ErrorModel.fromJson(e.response!.data));
      }
    case DioExceptionType.cancel:
      throw ServerExceptions(errModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.connectionError:
      throw ServerExceptions(errModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.unknown:
      throw ServerExceptions(errModel: ErrorModel.fromJson(e.response!.data));
  }
}
