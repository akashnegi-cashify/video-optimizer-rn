import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'part_list_history_response.g.dart';

@JsonSerializable()
class PartListHistoryResponse extends BaseResponse {
  @JsonKey(name: "dt")
  List<PartListHistoryData>? partListHistory;

  PartListHistoryResponse(this.partListHistory, super.cashifyAlert, super.trackUrl);

  static PartListHistoryResponse fromJson(Map<String, dynamic> json) => _$PartListHistoryResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PartListHistoryResponseToJson(this);
}

@JsonSerializable()
class PartListHistoryData {
  @JsonKey(name: "sku")
  String? sku;

  @JsonKey(name: "pn")
  String? partName;

  @JsonKey(name: "apn")
  String? alternatePartName;

  @JsonKey(name: "st")
  String? status;

  @JsonKey(name: "stc")
  int? statusCode;

  @JsonKey(name: "updby")
  String? updatedBy;

  @JsonKey(name: "updat")
  int? updatedAt;


  PartListHistoryData(
      {this.sku, this.partName, this.alternatePartName, this.status, this.statusCode, this.updatedBy, this.updatedAt});

  static PartListHistoryData fromJson(Map<String, dynamic> json) => _$PartListHistoryDataFromJson(json);

  Map<String, dynamic> toJson() => _$PartListHistoryDataToJson(this);
}
