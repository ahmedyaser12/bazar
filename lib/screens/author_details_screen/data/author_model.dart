import 'package:book_shop/screens/model/base_model.dart';

class AuthorDetailsModel extends BaseModel {
  String? info;
  List<String>? genres;
  List<AuthorBooks>? authorBooks;

  AuthorDetailsModel(
      {super.id,
      super.name,
      super.image,
      super.rating,
      this.info,
      this.genres,
      this.authorBooks});

  AuthorDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['author_id'];
    name = json['name'];
    image = json['image'];
    rating = json['rating'];
    info = json['info'];
    genres = json['genres'].cast<String>();
    if (json['author_books'] != null) {
      authorBooks = <AuthorBooks>[];
      json['author_books'].forEach((v) {
        authorBooks!.add(AuthorBooks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['author_id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['rating'] = this.rating;
    data['info'] = this.info;
    data['genres'] = this.genres;
    if (this.authorBooks != null) {
      data['author_books'] = this.authorBooks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AuthorBooks {
  String? url;
  String? bookId;
  String? name;
  double? rating;
  int? date;

  AuthorBooks({this.url, this.bookId, this.name, this.rating, this.date});

  AuthorBooks.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    bookId = json['bookId'];
    name = json['name'];
    rating = json['rating'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['bookId'] = this.bookId;
    data['name'] = this.name;
    data['rating'] = this.rating;
    data['date'] = this.date;
    return data;
  }
}
