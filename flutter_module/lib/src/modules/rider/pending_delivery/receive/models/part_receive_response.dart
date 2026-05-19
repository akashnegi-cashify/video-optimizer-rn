import 'package:json_annotation/json_annotation.dart';

part 'part_receive_response.g.dart';

@JsonSerializable()
class PartReceiveResponse {
  @JsonKey(name: "r_id")
  String? rid;

  @JsonKey(name: "s", defaultValue: false)
  late bool success;

  static PartReceiveResponse fromJson(Map<String, dynamic> data) => _$PartReceiveResponseFromJson(data);

  Map<String, dynamic> toJson() => _$PartReceiveResponseToJson(this);
}
