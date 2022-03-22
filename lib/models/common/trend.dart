import 'package:json_annotation/json_annotation.dart';
import 'package:mvideo/models/public.dart';

part 'trend.g.dart';

List<Trend> getTrendList(List<dynamic> list) {
  List<Trend> result = [];
  list.forEach((item) {
    result.add(Trend.fromJson(item));
  });
  return result;
}

@JsonSerializable()
class Trend extends Object {
  int? id;

  String? number;

  String? nickname;

  String? avatar;

  int? gender;

  int? type;

  Video? video;

  Trend({
    this.id,
    this.number,
    this.nickname,
    this.avatar,
    this.gender,
    this.type,
    this.video,
  });

  factory Trend.fromJson(Map<String, dynamic> srcJson) =>
      _$TrendFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TrendToJson(this);
}
