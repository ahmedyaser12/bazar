class TopWeakModel {
  int? bookId;
  String? name;
  String? cover;
  String? url;

  TopWeakModel({this.bookId, this.name, this.cover, this.url});

  TopWeakModel.fromJson(Map<String, dynamic> json) {
    bookId = json['book_id'];
    name = json['name'];
    cover = json['cover'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['book_id'] = this.bookId;
    data['name'] = this.name;
    data['cover'] = this.cover;
    data['url'] = this.url;
    return data;
  }
}
