import 'package:json_annotation/json_annotation.dart';
import 'package:mvideo/models/public.dart';

part 'histroy.g.dart';

@JsonSerializable()
class Histroy extends Object {
  int? id;

  @JsonKey(name: 'updateDate')
  String? time;

  Video? video;

  User? user;

  Histroy({this.id, this.time, this.video, this.user});

  factory Histroy.fromJson(Map<String, dynamic> srcJson) =>
      _$HistroyFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HistroyToJson(this);
}

List<Histroy> getHistroyList(List<dynamic> list) {
  List<Histroy> result = [];
  list.forEach((item) {
    result.add(Histroy.fromJson(item));
  });
  return result;
}
