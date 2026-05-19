import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/qc/modules/data_wipe/resources/data_wipe_list_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'data_wipe_detail_response.g.dart';

@JsonSerializable()
class DataWipeDetailResponse extends BaseResponse {
  @JsonKey(name: "dt")
  DataWipeListItem? dataWipeDetail;

  DataWipeDetailResponse(this.dataWipeDetail, super.cashifyAlert, super.trackUrl);

  static DataWipeDetailResponse fromJson(Map<String, dynamic> json) => _$DataWipeDetailResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DataWipeDetailResponseToJson(this);
}
