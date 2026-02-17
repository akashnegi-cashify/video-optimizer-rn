import 'package:json_annotation/json_annotation.dart';
part 'elss_part_submit_response.g.dart';

@JsonSerializable()
class ElssPartSubmitResponse {
  @JsonKey(name: "sm")
  String? successMessage;
  @JsonKey(name: "em")
  String? errorMessage;

  ElssPartSubmitResponse(
    this.errorMessage,
    this.successMessage,
  );

  static ElssPartSubmitResponse fromJson(Map<String, dynamic> data) => _$ElssPartSubmitResponseFromJson(data);

  Map<String, dynamic> toJson() => _$ElssPartSubmitResponseToJson(this);
}
