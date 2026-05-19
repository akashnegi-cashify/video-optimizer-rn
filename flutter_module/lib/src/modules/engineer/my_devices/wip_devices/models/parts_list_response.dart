import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

import 'engineer_part_info.dart';

part 'parts_list_response.g.dart';

@JsonSerializable()
class PartsListResponse extends BaseResponse {
  @JsonKey(name: "r_id")
  late String refId;
  @JsonKey(name: "s", defaultValue: false)
  late bool isSuccess;
  @JsonKey(name: "em")
  String? errorMsg;
  @JsonKey(name: "dt")
  List<EngineerPartInfo>? partDataList;

  PartsListResponse(super.cashifyAlert, super.trackUrl);

  static PartsListResponse fromJson(Map<String, dynamic> data) => _$PartsListResponseFromJson(data);

  @override
  Map<String, dynamic> toJson() => _$PartsListResponseToJson(this);
}
