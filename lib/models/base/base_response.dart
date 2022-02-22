import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

@JsonSerializable()
class BaseResponse {
  dynamic data;

  int code;

  String message;

  BaseResponse(
    this.data,
    this.code,
    this.message,
  );

  factory BaseResponse.fromJson(Map<String, dynamic> srcJson) =>
      _$BaseResponseFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);
}
