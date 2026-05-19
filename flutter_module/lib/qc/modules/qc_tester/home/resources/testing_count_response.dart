import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'testing_count_response.g.dart';

@JsonSerializable()
class TestingCountResponse extends BaseResponse {

  @JsonKey(name: "dt")
  TestingCountData? testingDeviceData;

  TestingCountResponse(this.testingDeviceData, super.cashifyAlert, super.trackUrl);

  static TestingCountResponse fromJson(Map<String, dynamic> json) => _$TestingCountResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TestingCountResponseToJson(this);
}

@JsonSerializable()
class TestingCountData {

  @JsonKey(name: "count")
  int? testingDeviceCount;

  @JsonKey(name: "lastUpdate")
  int? lastUpdatedDate;

  static TestingCountData fromJson(Map<String, dynamic> json) => _$TestingCountDataFromJson(json);

  Map<String, dynamic> toJson() => _$TestingCountDataToJson(this);
}
