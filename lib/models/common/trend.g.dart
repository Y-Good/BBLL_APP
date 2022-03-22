// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trend _$TrendFromJson(Map<String, dynamic> json) => Trend(
      id: json['id'] as int?,
      number: json['number'] as String?,
      nickname: json['nickname'] as String?,
      avatar: json['avatar'] as String?,
      gender: json['gender'] as int?,
      type: json['type'] as int?,
      video: json['video'] == null
          ? null
          : Video.fromJson(json['video'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TrendToJson(Trend instance) => <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'nickname': instance.nickname,
      'avatar': instance.avatar,
      'gender': instance.gender,
      'type': instance.type,
      'video': instance.video,
    };
