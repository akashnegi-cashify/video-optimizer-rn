import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'testing_count_response.g.dart';

@JsonSerializable()
class TestingCountResponse extends BaseResponse {
  @JsonKey(name: "c")
  int? testingDeviceCount;

  @JsonKey(name: "ud")
  int? lastUpdatedDate;

  TestingCountResponse(this.testingDeviceCount, this.lastUpdatedDate, super.cashifyAlert, super.trackUrl);

  static TestingCountResponse fromJson(Map<String, dynamic> json) => _$TestingCountResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TestingCountResponseToJson(this);
}
