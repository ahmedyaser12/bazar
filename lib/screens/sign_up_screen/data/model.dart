class SignUpModel {
  int? status;
  String? errorMessage;

  SignUpModel({this.status, this.errorMessage});

  SignUpModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errorMessage = json['ErrorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['ErrorMessage'] = this.errorMessage;
    return data;
  }
}
