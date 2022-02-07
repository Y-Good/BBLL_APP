class Video {
  int? id;
  String? cover;
  String? url;
  String? title;
  int? views;
  int? authorID;
  String? author;

  Video(
      {this.id,
      this.cover,
      this.url,
      this.title,
      this.views,
      this.authorID,
      this.author});

  static List<Video> fromJson(dynamic data) {
    final _list = <Video>[];
    for (var json in data) {
      _list.add(Video(
          id: json['id'],
          cover: json['cover'],
          url: json['url'],
          title: json['title'],
          views: json['views'],
          authorID: json['authorID'],
          author: json['author']));
    }
    return _list;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['cover'] = cover;
    data['url'] = url;
    data['title'] = title;
    data['views'] = views;
    data['authorID'] = authorID;
    data['author'] = author;
    return data;
  }
}
