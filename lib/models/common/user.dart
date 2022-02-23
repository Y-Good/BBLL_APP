import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  int? id;

  String? number;

  String? nickname;

  String? avatar;

  String? mobile;

  int? gender;

  String? birthday;

  int? type;

  String? signature;

  List<User>? follows;

  User({
    this.id,
    this.number,
    this.nickname,
    this.avatar,
    this.mobile,
    this.gender,
    this.birthday,
    this.type,
    this.signature,
    this.follows,
  });

  factory User.fromJson(Map<String, dynamic> srcJson) =>
      _$UserFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
