import 'package:json_annotation/json_annotation.dart';

part 'dead_mark_update_response.g.dart';

@JsonSerializable()
class DeadMarkUpdateResponse {
  @JsonKey(name: 'mr')
  String? markResponse;

  @JsonKey(name: 'qr_code')
  String? qrCode;

  @JsonKey(name: 'id')
  int? id;

  DeadMarkUpdateResponse({
    this.markResponse,
    this.qrCode,
    this.id,
  });

  static DeadMarkUpdateResponse fromJson(Map<String, dynamic> data) => _$DeadMarkUpdateResponseFromJson(data);

  Map<String, dynamic> toJson() => _$DeadMarkUpdateResponseToJson(this);
}
