import 'package:json_annotation/json_annotation.dart';
import 'package:mvideo/models/common/tag.dart';
import 'package:mvideo/models/public.dart';

part 'video.g.dart';

@JsonSerializable()
class Video extends Object {
  int? id;

  int? upId;

  String? title;

  int? category;

  int? view;

  int? thumbUp;

  int? collections;

  int? share;

  String? url;

  String? cover;

  User? user;

  List<Tag>? tags;

  Video({
    this.id,
    this.upId,
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