import 'package:json_annotation/json_annotation.dart';

part 'save_analytic_response.g.dart';

@JsonSerializable()
class SaveAnalyticsResponse {
  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "status")
  bool? status;

  SaveAnalyticsResponse(this.message, this.status);

  static SaveAnalyticsResponse fromJson(Map<String, dynamic> json) => _$SaveAnalyticsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SaveAnalyticsResponseToJson(this);
}
