import 'package:json_annotation/json_annotation.dart';

part 'cancel_part_request_response.g.dart';

@JsonSerializable()
class CancelPartResponse {
  @JsonKey(name: 'r_id')
  String? refId;

  CancelPartResponse({
    this.refId,
  });

  static CancelPartResponse fromJson(Map<String, dynamic> data) => _$CancelPartResponseFromJson(data);

  Map<String, dynamic> toJson() => _$CancelPartResponseToJson(this);
}
