import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

List<Category> getCategoryList(List<dynamic> list) {
  List<Category> result = [];
  list.forEach((item) {
    result.add(Category.fromJson(item));
  });
  return result;
}

@JsonSerializable()
class Category extends Object {
  int? id;

  String? name;

  Category({this.id, this.name});

  factory Category.fromJson(Map<String, dynamic> srcJson) =>
      _$TagFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TagToJson(this);
}
