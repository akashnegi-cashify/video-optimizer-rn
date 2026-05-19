import 'package:json_annotation/json_annotation.dart';

part 'alternate_part_request_response.g.dart';

@JsonSerializable()
class AlternatePartRequestResponse {
  @JsonKey(name: "r_id")
  String? rid;

  AlternatePartRequestResponse({
    this.rid,
  });

  static AlternatePartRequestResponse fromJson(Map<String, dynamic> data) =>
      _$AlternatePartRequestResponseFromJson(data);

  Map<String, dynamic> toJson() => _$AlternatePartRequestResponseToJson(this);
}

@JsonSerializable()
class AlternatePartRequestData {
  @JsonKey(name: "prid")
  int? prid;
  @JsonKey(name: "isUrgent")
  bool? isUrgent;

  AlternatePartRequestData({
    this.prid,
    this.isUrgent,
  });

  static AlternatePartRequestData fromJson(Map<String, dynamic> data) => _$AlternatePartRequestDataFromJson(data);

  Map<String, dynamic> toJson() => _$AlternatePartRequestDataToJson(this);
}
