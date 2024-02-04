class ErrorModel {
  final String message;

  ErrorModel(this.message);

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(json["message"]);
  }
}