import 'package:json_annotation/json_annotation.dart';
import 'package:mvideo/models/public.dart';

part 'comment.g.dart';

List<Comment> getCommentList(List<dynamic> list) {
  List<Comment> result = [];
  list.forEach((item) {
    result.add(Comment.fromJson(item));
  });
  return result;
}

@JsonSerializable()
class Comment extends Object {
  int? id;

  String? content;

  int? parentId;

  int? level;

  User? user;

  Video? video;

  @JsonKey(name: 'createDate')
  String? time;

  Comment({
    this.id,
    this.content,
    this.parentId,
    this.level,
    this.user,
    this.video,
    this.time,
  });

  factory Comment.fromJson(Map<String, dynamic> srcJson) =>
      _$CommentFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
