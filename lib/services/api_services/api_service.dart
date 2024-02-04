import 'package:book_shop/core/errors/exceptions.dart';
import 'package:book_shop/screens/book_detailes_screen/data/model.dart';
import 'package:book_shop/screens/home/data/top_author_model.dart';
import 'package:book_shop/screens/home/data/top_book_of_weak_model.dart';
import 'package:book_shop/services/api_services/dioconsumer.dart';
import 'package:book_shop/services/api_services/end_points.dart';

import '../../core/utils/resources.dart';
import '../../core/utils/status.dart';

class ApiService {
  DioConsumer api;

  ApiService(this.api);

  Future<Resource<List<TopWeakModel>>> getTopWeaklyBook() async {
    try {
      var response = await api.get(EndPoints.topWeakly);
      List<TopWeakModel> topWeak = [];
      for (var item in response) {
        topWeak.add(TopWeakModel.fromJson(item));
      }
      return Resource(Status.SUCCESS, data: topWeak);
    } on ServerExceptions catch (exception) {
      return Resource(Status.ERROR, errorMessage: exception.errModel.message);
    }
  }

  Future<Resource<List<TopAuthorsModel>>> getTopAuthors() async {
    try {
      var response = await api.get(
        EndPoints.topAuthors,
        queryParameter: {'limit': 10},
      );
      List<TopAuthorsModel> topAuthors = [];
      for (var item in response) {
        topAuthors.add(TopAuthorsModel.fromJson(item));
      }
      return Resource(Status.SUCCESS, data: topAuthors);
    } on ServerExceptions catch (exception) {
      return Resource(Status.ERROR, errorMessage: exception.errModel.message);
    }
  }

  Future<Resource<BookDetailsModel>> getBookDetails(int id) async {
    try {
      var response = await api.get("${EndPoints.bookDetails}/0");
      return Resource(Status.SUCCESS,
          data: BookDetailsModel.fromJson(response));
    } on ServerExceptions catch (exception) {
      return Resource(Status.ERROR, errorMessage: exception.errModel.message);
    }
  }
}
