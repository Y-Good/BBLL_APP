// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Video _$VideoFromJson(Map<String, dynamic> json) => Video(
      id: json['id'] as int,
      title: json['title'] as String?,
      category: json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>),
      view: json['view'] as String?,
      thumbUp: json['thumbUp'] as String?,
      share: json['share'] as String?,
      url: json['url'] as String?,
      cover: json['cover'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList(),
      duration: json['duration'] as String?,
      time: json['createDate'] as String?,
    );

Map<String, dynamic> _$VideoToJson(Video instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'view': instance.view,
      'thumbUp': instance.thumbUp,
      'share': instance.share,
      'url': instance.url,
      'cover': instance.cover,
      'user': instance.user,
      'duration': instance.duration,
      'tags': instance.tags,
      'category': instance.category,
      'createDate': instance.time,
    };
