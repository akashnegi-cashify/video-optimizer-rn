import 'package:flutter_trc/src/modules/rider/pending_delivery/receive/models/receive_response_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'engineer_parts_response.g.dart';

@JsonSerializable()
class EngineerPartsResponse {
  @JsonKey(name: "r_id")
  String? rid;

  @JsonKey(name: "s", defaultValue: false)
  late bool success;

  @JsonKey(name: "dt")
  List<Part>? parts;

  static EngineerPartsResponse fromJson(Map<String, dynamic> data) => _$EngineerPartsResponseFromJson(data);

  Map<String, dynamic> toJson() => _$EngineerPartsResponseToJson(this);
}
