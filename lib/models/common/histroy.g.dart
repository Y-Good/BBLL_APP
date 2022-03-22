// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'histroy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Histroy _$HistroyFromJson(Map<String, dynamic> json) => Histroy(
      id: json['id'] as int?,
      time: json['updateDate'] as String?,
      video: json['video'] == null
          ? null
          : Video.fromJson(json['video'] as Map<String, dynamic>),
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HistroyToJson(Histroy instance) => <String, dynamic>{
      'id': instance.id,
      'updateDate': instance.time,
      'video': instance.video,
      'user': instance.user,
    };
