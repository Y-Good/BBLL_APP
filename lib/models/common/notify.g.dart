// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notify.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notify _$NotifyFromJson(Map<String, dynamic> json) => Notify(
      id: json['id'] as int?,
      type: $enumDecodeNullable(_$NotifyTypeEnumMap, json['type']),
      isRead: json['isRead'] as int?,
      fromUser: json['fromUser'] == null
          ? null
          : User.fromJson(json['fromUser'] as Map<String, dynamic>),
      video: json['video'] == null
          ? null
          : Video.fromJson(json['video'] as Map<String, dynamic>),
      comment: json['comment'] == null
          ? null
          : Comment.fromJson(json['comment'] as Map<String, dynamic>),
      time: json['createDate'] as String?,
    );

Map<String, dynamic> _$NotifyToJson(Notify instance) => <String, dynamic>{
      'id': instance.id,
      'type': _$NotifyTypeEnumMap[instance.type],
      'isRead': instance.isRead,
      'fromUser': instance.fromUser,
      'video': instance.video,
      'comment': instance.comment,
      'createDate': instance.time,
    };

const _$NotifyTypeEnumMap = {
  NotifyType.thumbUp: 'thumbUp',
  NotifyType.comment: 'comment',
};
