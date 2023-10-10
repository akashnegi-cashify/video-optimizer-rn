import 'package:json_annotation/json_annotation.dart';

import 'index.dart';

part 'complete_pre_dispatch_response.g.dart';

@JsonSerializable()
class CompletePreDispatchResponse {
  @JsonKey(name: "cm")
  String? message;

  @JsonKey(name: "s")
  bool? status;

  @JsonKey(name: "success")
  bool? success;

  @JsonKey(name: "tc")
  int? totalCount;

  @JsonKey(name: "em")
  String? errorMessage;

  CompletePreDispatchResponse({
    this.message,
    this.status,
    this.success,
    this.totalCount,
    this.errorMessage,
  });

  static CompletePreDispatchResponse fromJson(Map<String, dynamic> data) => _$CompletePreDispatchResponseFromJson(data);

  Map<String, dynamic> toJson() => _$CompletePreDispatchResponseToJson(this);

  bool isValid(){
    return status == true;
  }
}
