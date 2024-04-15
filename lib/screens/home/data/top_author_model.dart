class TopAuthorsModel {
  int? authorId;
  String? name;
  String? image;
  String? url;
  String? popularBookTitle;
  String? popularBookUrl;
  int? numberPublishedBooks;

  TopAuthorsModel(
      {this.authorId,
        this.name,
        this.image,
        this.url,
        this.popularBookTitle,
        this.popularBookUrl,
        this.numberPublishedBooks});

  TopAuthorsModel.fromJson(Map<String, dynamic> json) {
    authorId = json['author_id'];
    name = json['name'];
    image = json['image'];
    url = json['url'];
    popularBookTitle = json['popular_book_title'];
    popularBookUrl = json['popular_book_url'];
    numberPublishedBooks = json['number_published_books'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['author_id'] = this.authorId;
    data['name'] = this.name;
    data['image'] = this.image;
    data['url'] = this.url;
    data['popular_book_title'] = this.popularBookTitle;
    data['popular_book_url'] = this.popularBookUrl;
    data['number_published_books'] = this.numberPublishedBooks;
    return data;
  }
}
