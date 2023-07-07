import 'package:json_annotation/json_annotation.dart';

part 'save_analytic_request.g.dart';

@JsonSerializable()
class SaveAnalyticsRequest {
  @JsonKey(name: "ekey")
  String? eventKey;

  @JsonKey(name: "sokey")
  String? subOrdinateEventKey;

  @JsonKey(name: "params")
  Map<String, dynamic>? parameters;

  SaveAnalyticsRequest(this.eventKey, this.subOrdinateEventKey, {this.parameters});

  static SaveAnalyticsRequest fromJson(Map<String, dynamic> json) => _$SaveAnalyticsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SaveAnalyticsRequestToJson(this);
}
