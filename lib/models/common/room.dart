import 'package:json_annotation/json_annotation.dart';
import 'package:mvideo/models/public.dart';

part 'room.g.dart';

List<Room> getRoomList(List<dynamic> list) {
  List<Room> result = [];
  list.forEach((item) {
    result.add(Room.fromJson(item));
  });
  return result;
}

@JsonSerializable()
class Room extends Object {
  User? user;

  Video? video;

  String? room;

  Room({this.user, this.video, this.room});

  factory Room.fromJson(Map<String, dynamic> srcJson) =>
      _$RoomFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RoomToJson(this);
}
