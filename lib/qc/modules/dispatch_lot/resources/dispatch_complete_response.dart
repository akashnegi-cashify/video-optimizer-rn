import 'package:json_annotation/json_annotation.dart';

part 'dispatch_complete_response.g.dart';

@JsonSerializable()
class DispatchCompleteResponse {
  @JsonKey(name: "dt")
  String? data;

  @JsonKey(name: "em")
  String? errorMsg;

  @JsonKey(name: "s")
  bool? isSuccess;

  DispatchCompleteResponse({
    this.data,
    this.errorMsg,
    this.isSuccess,
  });

  static DispatchCompleteResponse fromJson(Map<String, dynamic> data) => _$DispatchCompleteResponseFromJson(data);

  Map<String, dynamic> toJson() => _$DispatchCompleteResponseToJson(this);
}
