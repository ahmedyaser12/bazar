import 'status.dart';

class Resource<T> {
  T? data;
  Status? status;
  String? errorMessage;
  List<dynamic>? errorList;

  Resource(this.status, {this.data, this.errorMessage, this.errorList});
}
