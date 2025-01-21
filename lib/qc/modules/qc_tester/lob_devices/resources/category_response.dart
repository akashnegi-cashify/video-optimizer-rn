import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/device_detail_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_response.g.dart';

@JsonSerializable()
class CategoryResponse extends BaseResponse {
  @JsonKey(name: "cat")
  CategoryData? categoryData;

  CategoryResponse(this.categoryData, super.cashifyAlert, super.trackUrl);

  static CategoryResponse fromJson(Map<String, dynamic> json) => _$CategoryResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CategoryResponseToJson(this);
}
