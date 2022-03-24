import 'package:json_annotation/json_annotation.dart';
import 'package:mvideo/models/public.dart';

part 'message.g.dart';

@JsonSerializable()
class Message extends Object {
  String? data;

  User? user;

  Message({this.data, this.user});

  factory Message.fromJson(Map<String, dynamic> srcJson) =>
      _$MessageFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
