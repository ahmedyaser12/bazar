import 'package:book_shop/screens/model/base_model.dart';

class TopWeakModel extends BaseModel {
  String? url;

  TopWeakModel(
      {super.id, super.name, super.image, super.rating, required this.url});

  TopWeakModel.fromJson(Map<String, dynamic> json) {
    id = json['book_id'];
    name = json['name'];
    image = json['cover'];
    rating = json['rating'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['book_id'] = this.id;
    data['name'] = this.name;
    data['cover'] = this.image;
    data['rating'] = this.rating;
    data['url'] = this.url;
    return data;
  }
}
