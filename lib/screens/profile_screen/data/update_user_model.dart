import 'package:book_shop/services/api_services/end_points.dart';

class UpdateUser {
  String? message;

  UpdateUser(this.message);

  factory UpdateUser.fromJson(Map<String, dynamic> json) {
    return UpdateUser(json[ApiKey.message]);
  }
}
