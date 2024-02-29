import '../../services/api_services/end_points.dart';

class ErrorModel {
  final int? status;
  final String? errorMessage;
  final String? message;
  final List<dynamic>? errorList;

  ErrorModel(
    this.errorList,
    this.message, {
    required this.status,
    required this.errorMessage,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> jsonData) {
    return ErrorModel(
      jsonData[ApiKey.errorList],
      jsonData['message'],
      status: jsonData[ApiKey.status],
      errorMessage: jsonData[ApiKey.errorMessage],
    );
  }
}
