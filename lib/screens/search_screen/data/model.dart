import 'package:book_shop/screens/model/base_model.dart';

class SearchModel extends BaseModel {
  final String? url;
  final List<String>? authors;
  final int? createdEditions;
  final int? year;

  SearchModel({
    int? id,
    String? name,
    String? image,
    double? rating,
    this.url,
    this.authors,
    this.createdEditions,
    this.year,
  }) : super(id: id, name: name, image: image, rating: rating);

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      id: json['book_id'],
      name: json['name'],
      image: json['cover'],
      rating: json['rating']?.toDouble(),
      // Ensure this conversion handles nulls if needed
      url: json['url'],
      authors: List<String>.from(json['authors'] ?? []),
      createdEditions: json['created_editions'],
      year: json['year'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'book_id': id,
      'name': name,
      'cover': image,
      'url': url,
      'authors': authors,
      'rating': rating,
      'created_editions': createdEditions,
      'year': year,
    };
  }
}
