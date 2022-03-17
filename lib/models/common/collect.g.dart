// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collect.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Collect _$CollectFromJson(Map<String, dynamic> json) => Collect(
      id: json['id'] as int?,
      type: json['type'] as String?,
      video: json['video'] == null
          ? null
          : Video.fromJson(json['video'] as Map<String, dynamic>),
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      time: json['createDate'] as String?,
      follow: json['follow'] == null
          ? null
          : User.fromJson(json['follow'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CollectToJson(Collect instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'video': instance.video,
      'user': instance.user,
      'follow': instance.follow,
      'createDate': instance.time,
    };
