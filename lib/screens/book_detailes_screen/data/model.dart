class BookDetailsModel {
  int? bookId;
  String? name;
  String? cover;
  String? url;
  List<String>? authors;
  double? rating;
  int? pages;
  String? publishedDate;
  String? synopsis;

  BookDetailsModel(
      {this.bookId,
        this.name,
        this.cover,
        this.url,
        this.authors,
        this.rating,
        this.pages,
        this.publishedDate,
        this.synopsis});

  BookDetailsModel.fromJson(Map<String, dynamic> json) {
    bookId = json['book_id'];
    name = json['name'];
    cover = json['cover'];
    url = json['url'];
    authors = json['authors'].cast<String>();
    rating = json['rating'];
    pages = json['pages'];
    publishedDate = json['published_date'];
    synopsis = json['synopsis'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['book_id'] = this.bookId;
    data['name'] = this.name;
    data['cover'] = this.cover;
    data['url'] = this.url;
    data['authors'] = this.authors;
    data['rating'] = this.rating;
    data['pages'] = this.pages;
    data['published_date'] = this.publishedDate;
    data['synopsis'] = this.synopsis;
    return data;
  }
}
