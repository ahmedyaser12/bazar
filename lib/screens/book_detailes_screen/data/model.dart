import 'package:book_shop/screens/model/base_model.dart';

class BookDetailsModel extends BaseModel {
  String? url;
  List<String>? authors;
  int? pages;
  String? publishedDate;
  String? synopsis;

  BookDetailsModel(
      {super.id,
      super.name,
      super.image,
      this.url,
      this.authors,
      super.rating,
      this.pages,
      this.publishedDate,
      this.synopsis});

  BookDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['book_id'];
    name = json['name'];
    image = json['cover'];
    url = json['url'];
    authors = json['authors'].cast<String>();
    rating =double.parse( json['rating'].toString());
    pages = json['pages'];
    publishedDate = json['published_date'];
    synopsis = json['synopsis'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['book_id'] = this.id;
    data['name'] = this.name;
    data['cover'] = this.image;
    data['url'] = this.url;
    data['authors'] = this.authors;
    data['rating'] = rating;
    data['pages'] = this.pages;
    data['published_date'] = this.publishedDate;
    data['synopsis'] = this.synopsis;
    return data;
  }
}
