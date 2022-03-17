import 'package:json_annotation/json_annotation.dart';
import 'package:mvideo/models/public.dart';

part 'collect.g.dart';

List<Collect> getCollectList(List<dynamic> list) {
  List<Collect> result = [];
  list.forEach((item) {
    result.add(Collect.fromJson(item));
  });
  return result;
}

@JsonSerializable()
class Collect extends Object {
  int? id;

  String? type;

  Video? video;

  User? user;

  User? follow;

  @JsonKey(name: 'createDate')
  String? time;

  Collect({this.id, this.type, this.video, this.user, this.time, this.follow});

  factory Collect.fromJson(Map<String, dynamic> srcJson) =>
      _$CollectFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CollectToJson(this);
}
