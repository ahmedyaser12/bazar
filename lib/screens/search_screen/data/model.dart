class SearchModel {
  int? bookId;
  String? name;
  String? cover;
  String? url;
  List<String>? authors;
  double? rating;
  int? createdEditions;
  int? year;

  SearchModel(
      {this.bookId,
      this.name,
      this.cover,
      this.url,
      this.authors,
      this.rating,
      this.createdEditions,
      this.year});

  SearchModel.fromJson(Map<String, dynamic> json) {
    bookId = json['book_id'];
    name = json['name'];
    cover = json['cover'];
    url = json['url'];
    authors = json['authors'].cast<String>();
    rating = json['rating'];
    createdEditions = json['created_editions'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['book_id'] = this.bookId;
    data['name'] = this.name;
    data['cover'] = this.cover;
    data['url'] = this.url;
    data['authors'] = this.authors;
    data['rating'] = this.rating;
    data['created_editions'] = this.createdEditions;
    data['year'] = this.year;
    return data;
  }
}
