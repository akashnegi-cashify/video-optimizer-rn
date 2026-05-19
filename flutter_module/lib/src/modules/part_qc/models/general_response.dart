import 'package:json_annotation/json_annotation.dart';

part 'general_response.g.dart';

@JsonSerializable()
class GeneralResponse {
  @JsonKey(name: "r_id")
  String? refId;

  GeneralResponse({
    this.refId,
  });

  static GeneralResponse fromJson(Map<String, dynamic> data) => _$GeneralResponseFromJson(data);

  Map<String, dynamic> toJson() => _$GeneralResponseToJson(this);
}
