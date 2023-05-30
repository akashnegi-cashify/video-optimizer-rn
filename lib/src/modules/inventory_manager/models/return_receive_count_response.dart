import 'package:json_annotation/json_annotation.dart';

part 'return_receive_count_response.g.dart';

@JsonSerializable()
class ReturnCountResponse {
  @JsonKey(name: "r_id")
  String? rid;
  @JsonKey(name: "s")
  bool? isSuccess;
  @JsonKey(name: "dt")
  ReturnCountDataResponse? data;

  ReturnCountResponse({
    this.isSuccess,
    this.rid,
    this.data,
  });

  static ReturnCountResponse fromJson(Map<String, dynamic> data) => _$ReturnCountResponseFromJson(data);

  Map<String, dynamic> toJson() => _$ReturnCountResponseToJson(this);
}

@JsonSerializable()
class ReturnCountDataResponse {
  @JsonKey(name: "rc")
  int? pendingReturnCount;

  ReturnCountDataResponse({
    this.pendingReturnCount,
  });

  static ReturnCountDataResponse fromJson(Map<String, dynamic> data) => _$ReturnCountDataResponseFromJson(data);

  Map<String, dynamic> toJson() => _$ReturnCountDataResponseToJson(this);
}
