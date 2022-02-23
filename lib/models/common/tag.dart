import 'package:json_annotation/json_annotation.dart';

part 'tag.g.dart';

List<Tag> getTagList(List<dynamic> list) {
  List<Tag> result = [];
  list.forEach((item) {
    result.add(Tag.fromJson(item));
  });
  return result;
}

@JsonSerializable()
class Tag extends Object {
  int? id;

  String? name;

  Tag({this.id, this.name});

  factory Tag.fromJson(Map<String, dynamic> srcJson) => _$TagFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TagToJson(this);
}
