import 'package:json_annotation/json_annotation.dart';
part 'elss_part_submit_response.g.dart';

@JsonSerializable()
class ElssPartSubmitResponse {
  @JsonKey(name: "s")
  bool? isSuccess;
  @JsonKey(name: "sm")
  String? successMessage;
  @JsonKey(name: "em")
  String? errorMessage;

  ElssPartSubmitResponse(
    this.isSuccess,
    this.errorMessage,
    this.successMessage,
  );

  static ElssPartSubmitResponse fromJson(Map<String, dynamic> data) => _$ElssPartSubmitResponseFromJson(data);

  Map<String, dynamic> toJson() => _$ElssPartSubmitResponseToJson(this);
}
