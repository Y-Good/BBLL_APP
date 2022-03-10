import 'package:json_annotation/json_annotation.dart';
import 'package:mvideo/models/common/category.dart';
import 'package:mvideo/models/common/tag.dart';
import 'package:mvideo/models/public.dart';

part 'video.g.dart';

@JsonSerializable()
class Video extends Object {
  int id;

  String? title;

  int? view;

  int? thumbUp;

  int? collections;

  int? share;

  String? url;

  String? cover;

  User? user;

  int? duration;

  List<Tag>? tags;

  Category? category;

  @JsonKey(name: 'createDate')
  String? time;

  Video({
    required this.id,
    this.title,
    this.category,
    this.view,
    this.thumbUp,
    this.collections,
    this.share,
    this.url,
    this.cover,
    this.user,
    this.tags,
    this.duration,
    this.time,
  });

  factory Video.fromJson(Map<String, dynamic> srcJson) =>
      _$VideoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$VideoToJson(this);
}

List<Video> getVideoList(List<dynamic> list) {
  List<Video> result = [];
  list.forEach((item) {
    result.add(Video.fromJson(item));
  });
  return result;
}
