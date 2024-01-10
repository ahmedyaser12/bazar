import 'package:book_shop/core/utils/constant.dart';
import 'package:book_shop/screens/home/data/model.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../core/utils/resources.dart';
import '../core/utils/status.dart';

class ApiService {
  final String baseUrl;
  final Dio dio;

  ApiService(this.baseUrl) : dio = Dio(BaseOptions(baseUrl: baseUrl)) {
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      error: true,
      compact: true,
      maxWidth: 90,
    ));
    dio.options.headers = {
      'X-RapidAPI-Key': AppConstance.apiKey,
      'X-RapidAPI-Host': AppConstance.apiHost
    };
  }

  Future<Resource<List<TopWeakModel>>> getTopWeaklyBook() async {
    try {
      var response = await dio.get("$baseUrl${AppConstance.topWeakly}");
      List<TopWeakModel> topWeak = [];
      for (var item in response.data) {
        topWeak.add(TopWeakModel.fromJson(item));
      }
      return Resource(Status.SUCCESS, data: topWeak);
    } catch (exception) {
      return Resource(Status.ERROR, errorMessage: exception.toString());
    }
  }
}
