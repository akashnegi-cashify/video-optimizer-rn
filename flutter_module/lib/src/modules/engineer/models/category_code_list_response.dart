import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_code_list_response.g.dart';

@JsonSerializable()
class CategoryCodeListResponse extends BaseResponse {
  @JsonKey(name: "dt")
  List<String>? categoryCodeList;

  CategoryCodeListResponse(this.categoryCodeList, super.cashifyAlert, super.trackUrl);

  static CategoryCodeListResponse fromJson(Map<String, dynamic> json) => _$CategoryCodeListResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CategoryCodeListResponseToJson(this);
}
