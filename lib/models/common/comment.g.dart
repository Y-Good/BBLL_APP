// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      id: json['id'] as int?,
      content: json['content'] as String?,
      parentId: json['parentId'] as int?,
      level: json['level'] as int?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      replyUser: json['replyUser'] == null
          ? null
          : User.fromJson(json['replyUser'] as Map<String, dynamic>),
      video: json['video'] == null
          ? null
          : Video.fromJson(json['video'] as Map<String, dynamic>),
      time: json['createDate'] as String?,
      replyCount: json['replyCount'] as int?,
      thumbUpCount: json['thumbUpCount'] as int?,
      isThumbUp: json['isThumbUp'] as bool,
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'parentId': instance.parentId,
      'level': instance.level,
      'user': instance.user,
      'replyUser': instance.replyUser,
      'video': instance.video,
      'replyCount': instance.replyCount,
      'thumbUpCount': instance.thumbUpCount,
      'createDate': instance.time,
    };
