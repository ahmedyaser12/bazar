import 'package:book_shop/services/api_services/end_points.dart';

class SignUpModel {
  String? message;

  SignUpModel({this.message});

  SignUpModel.fromJson(Map<String, dynamic> json) {
    message = json[ApiKey.message];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[ApiKey.message] = message;
    return data;
  }
}
