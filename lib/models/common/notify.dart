import 'package:json_annotation/json_annotation.dart';
import 'package:mvideo/common/enums/notify.enum.dart';
import 'package:mvideo/models/public.dart';

part 'notify.g.dart';

List<Notify> getNotifyList(List<dynamic> list) {
  List<Notify> result = [];
  list.forEach((item) {
    result.add(Notify.fromJson(item));
  });
  return result;
}

@JsonSerializable()
class Notify extends Object {
  int? id;

  NotifyType? type;

  int? isRead;

  User? fromUser;

  Video? video;

  Comment? comment;

  @JsonKey(name: 'createDate')
  String? time;

  Notify({
    this.id,
    this.type,
    this.isRead,
    this.fromUser,
    this.video,
    this.comment,
    this.time,
  });

  factory Notify.fromJson(Map<String, dynamic> srcJson) =>
      _$NotifyFromJson(srcJson);

  Map<String, dynamic> toJson() => _$NotifyToJson(this);
}
