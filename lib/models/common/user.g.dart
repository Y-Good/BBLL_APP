// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int?,
      number: json['number'] as String?,
      nickname: json['nickname'] as String?,
      avatar: json['avatar'] as String?,
      mobile: json['mobile'] as String?,
      gender: json['gender'] as int?,
      birthday: json['birthday'] as String?,
      type: json['type'] as int?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'nickname': instance.nickname,
      'avatar': instance.avatar,
      'mobile': instance.mobile,
      'gender': instance.gender,
      'birthday': instance.birthday,
      'type': instance.type,
    };
