import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 're_qc_list_response.g.dart';

@JsonSerializable()
class ReQcListResponse extends BaseResponse {
  @JsonKey(name: 'dt')
  List<ReQcListData>? list;

  ReQcListResponse(this.list, super.cashifyAlert, super.trackUrl);

  static ReQcListResponse fromJson(Map<String, dynamic> json) => _$ReQcListResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ReQcListResponseToJson(this);
}

@JsonSerializable()
class ReQcListData {
  @JsonKey(name: "lgn")
  String? lotGroupName;

  @JsonKey(name: "lc")
  int? lotCount;

  @JsonKey(name: "pc")
  int? pendingCount;

  @JsonKey(name: "dc")
  int? doneCount;

  @JsonKey(name: "ac")
  int? auditCount;

  @JsonKey(name: "lt")
  String? lotType;

  @JsonKey(name: "srqc")
  bool? skipReQc;

  ReQcListData(
      {this.lotGroupName,
      this.lotCount,
      this.pendingCount,
      this.doneCount,
      this.auditCount,
      this.lotType,
      this.skipReQc});

  static ReQcListData fromJson(Map<String, dynamic> json) => _$ReQcListDataFromJson(json);

  Map<String, dynamic> toJson() => _$ReQcListDataToJson(this);
}
