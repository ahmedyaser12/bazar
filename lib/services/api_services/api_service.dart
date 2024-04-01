import 'package:book_shop/core/errors/exceptions.dart';
import 'package:book_shop/screens/author_details_screen/data/author_model.dart';
import 'package:book_shop/screens/book_detailes_screen/data/model.dart';
import 'package:book_shop/screens/home/data/top_author_model.dart';
import 'package:book_shop/screens/home/data/top_book_of_weak_model.dart';
import 'package:book_shop/screens/login_screen/data/model/sign_in_model.dart';
import 'package:book_shop/screens/profile_screen/data/update_user_model.dart';
import 'package:book_shop/screens/profile_screen/data/user_model.dart';
import 'package:book_shop/screens/search_screen/data/model.dart';
import 'package:book_shop/screens/sign_up_screen/data/model.dart';
import 'package:book_shop/services/api_services/dioconsumer.dart';
import 'package:book_shop/services/api_services/end_points.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/helper/cache_helper.dart';
import '../../core/utils/resources.dart';
import '../../core/utils/status.dart';
import '../services_locator.dart';

class ApiService {
  ApiService();

  Future<Resource<SignUpModel>> signUp({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String confirmPassword,
    required XFile profilePic,
  }) async {
    try {
      var authApi = DioConsumer(
          '${CacheHelper().getData(key: ApiKey.token) != null ? 'FOODAPI ${CacheHelper().getData(key: ApiKey.token)}' : null}',
          ApiKey.token,
          dio: locator<Dio>(),
          baseUrl: EndPoints.authBaseUrl);
      // print('Auth check api ${authApi.isAuth}');
      var response =
          await authApi.post(EndPoints.signUp, isFormData: true, data: {
        ApiKey.name: name,
        ApiKey.phone: phone,
        ApiKey.email: email,
        ApiKey.password: password,
        ApiKey.confirmPassword: confirmPassword,
        ApiKey.location:
            '{"name":"methalfa","address":"meet halfa","coordinates":[30.1572709,31.224779]}',
        ApiKey.profilePic: await MultipartFile.fromFile(profilePic.path,
            filename: profilePic.path.split('/').last),
      });
      return Resource(Status.SUCCESS, data: SignUpModel.fromJson(response));
    } on ServerExceptions catch (exception) {
      return Resource(Status.ERROR,
          errorMessage: exception.errModel.errorMessage,
          errorList: exception.errModel.errorList);
    }
  }

  Future<Resource<SignInModel>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      var authApi = DioConsumer(
          '${CacheHelper().getData(key: ApiKey.token) != null ? 'FOODAPI ${CacheHelper().getData(key: ApiKey.token)}' : null}',
          ApiKey.token,
          dio: locator<Dio>(),
          baseUrl: EndPoints.authBaseUrl);
      var response =
          await authApi.post(EndPoints.signIn, isFormData: true, data: {
        ApiKey.email: email,
        ApiKey.password: password,
      });
      return Resource(Status.SUCCESS, data: SignInModel.fromJson(response));
    } on ServerExceptions catch (exception) {
      return Resource(Status.ERROR,
          errorMessage: exception.errModel.errorMessage,
          errorList: exception.errModel.errorList);
    }
  }

  Future<Resource<UpdateUser>> updateProfile({
    required String name,
    required String phone,
    XFile? profilePic, // Note: Make sure profilePic is nullable
  }) async {
    try {
      var authApi = DioConsumer(
          '${CacheHelper().getData(key: ApiKey.token) != null ? 'FOODAPI ${CacheHelper().getData(key: ApiKey.token)}' : null}',
          ApiKey.token,
          dio: locator<Dio>(),
          baseUrl: EndPoints.authBaseUrl);
      Map<String, dynamic> data = {
        ApiKey.name: name,
        ApiKey.phone: phone,
        ApiKey.location:
            '{"name":"methalfa","address":"meet halfa","coordinates":[30.1572709,31.224779]}',
      };

      if (profilePic != null) {
        data[ApiKey.profilePic] = await MultipartFile.fromFile(profilePic.path,
            filename: profilePic.path.split('/').last);
      }

      var response =
          await authApi.patch(EndPoints.update, isFormData: true, data: data);
      return Resource(Status.SUCCESS, data: UpdateUser.fromJson(response));
    } on ServerExceptions catch (exception) {
      return Resource(
        Status.ERROR,
        errorMessage: exception.errModel.errorMessage,
      );
    }
  }

  Future<Resource<UserModel>> getUser({
    required String id,
  }) async {
    try {
      var authApi = DioConsumer(
          '${CacheHelper().getData(key: ApiKey.token) != null ? 'FOODAPI ${CacheHelper().getData(key: ApiKey.token)}' : null}',
          ApiKey.token,
          dio: locator<Dio>(),
          baseUrl: EndPoints.authBaseUrl);
      var response = await authApi.get('${EndPoints.get_user}/$id');
      return Resource(Status.SUCCESS, data: UserModel.fromJson(response));
    } on ServerExceptions catch (exception) {
      return Resource(Status.ERROR,
          errorMessage: exception.errModel.errorMessage);
    }
  }

  Future<Resource<List<TopWeakModel>>> getTopWeaklyBook() async {
    try {
      var api = DioConsumer(EndPoints.apiKey, "X-RapidAPI-Key",
          dio: locator<Dio>(), baseUrl: EndPoints.baseUrl);
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
      var api = DioConsumer(EndPoints.apiKey, "X-RapidAPI-Key",
          dio: locator<Dio>(), baseUrl: EndPoints.baseUrl);
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
      return Resource(Status.ERROR,
          errorMessage: exception.errModel.errorMessage);
    }
  }

  Future<Resource<BookDetailsModel>> getBookDetails(int id) async {
    try {
      var api = DioConsumer(EndPoints.apiKey, "X-RapidAPI-Key",
          dio: locator<Dio>(), baseUrl: EndPoints.baseUrl);
      var response = await api.get("${EndPoints.bookDetails}/$id");
      return Resource(Status.SUCCESS,
          data: BookDetailsModel.fromJson(response));
    } on ServerExceptions catch (exception) {
      return Resource(Status.ERROR,
          errorMessage: exception.errModel.errorMessage);
    }
  }

  Future<Resource<AuthorDetailsModel>> getAuthorDetails(int id) async {
    try {
      var api = DioConsumer(EndPoints.apiKey, "X-RapidAPI-Key",
          dio: locator<Dio>(), baseUrl: EndPoints.baseUrl);
      var response = await api.get("${EndPoints.authorDetails}/$id");
      return Resource(Status.SUCCESS,
          data: AuthorDetailsModel.fromJson(response));
    } on ServerExceptions catch (exception) {
      return Resource(Status.ERROR,
          errorMessage: exception.errModel.errorMessage);
    }
  }

  Future<Resource<List<TopWeakModel>>> getCategories(
      String typeOfCategory) async {
    try {
      var api = DioConsumer(EndPoints.apiKey, "X-RapidAPI-Key",
          dio: locator<Dio>(), baseUrl: EndPoints.baseUrl);
      var response = await api.get('${EndPoints.category}/$typeOfCategory/10');
      List<TopWeakModel> topWeak = [];
      for (var item in response) {
        topWeak.add(TopWeakModel.fromJson(item));
      }
      return Resource(Status.SUCCESS, data: topWeak);
    } on ServerExceptions catch (exception) {
      return Resource(Status.ERROR,
          errorMessage: exception.errModel.errorMessage);
    }
  }

  Future<Resource<List<SearchModel>>> searchBook(String bookName) async {
    try {
      var api = DioConsumer(EndPoints.apiKey, "X-RapidAPI-Key",
          dio: locator<Dio>(), baseUrl: EndPoints.baseUrl);
      var response = await api.get('${EndPoints.searchBook}/$bookName');
      List<SearchModel> searchBook = [];
      for (var item in response) {
        searchBook.add(SearchModel.fromJson(item));
      }
      return Resource(Status.SUCCESS, data: searchBook);
    } on ServerExceptions catch (exception) {
      return Resource(Status.ERROR,
          errorMessage: exception.errModel.errorMessage);
    }
  }

  Future<Resource<String>> getAuthToken() async {
    try {
      var api = DioConsumer(null, null,
          dio: locator<Dio>(), baseUrl: EndPoints.paymentBaseUrl);
      var response = await api.get(EndPoints.paymentAuthToken,data: {
        'api_key': EndPoints.paymentApiKey
      });
      var token = response['token'];
      return Resource(Status.SUCCESS, data: token);
    } on ServerExceptions catch (exception) {
      return Resource(Status.ERROR,
          errorMessage: exception.errModel.errorMessage);
    }
  }
}
