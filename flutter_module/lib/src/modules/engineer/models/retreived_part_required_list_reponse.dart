import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/part_detail/models/retrieved_part_reason_list_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'retreived_part_required_list_reponse.g.dart';

@JsonSerializable()
class RetrievedPartRequiredResponse {
  @JsonKey(name: "r_id")
  String? rId;
  @JsonKey(name: "dt")
  RetrievedPartRequiredData? data;

  RetrievedPartRequiredResponse({
    this.rId,
    this.data,
  });

  static RetrievedPartRequiredResponse fromJson(Map<String, dynamic> data) =>
      _$RetrievedPartRequiredResponseFromJson(data);

  Map<String, dynamic> toJson() => _$RetrievedPartRequiredResponseToJson(this);
}

@JsonSerializable()
class RetrievedPartRequiredData {
  @JsonKey(name: "r_id")
  String? rId;
  @JsonKey(name: "pl")
  List<RetrievedPartListResponseData>? partList;

  RetrievedPartRequiredData({
    this.rId,
    this.partList,
  });

  static RetrievedPartRequiredData fromJson(Map<String, dynamic> data) => _$RetrievedPartRequiredDataFromJson(data);

  Map<String, dynamic> toJson() => _$RetrievedPartRequiredDataToJson(this);
}

@JsonSerializable()
class RetrievedPartListResponseData {
  @JsonKey(name: "prn")
  String? partRequestName;
  @JsonKey(name: "prid")
  int? partRequestId;
  @JsonKey(name: "ccd")
  String? categoryCode;
  @JsonKey(name: "prr")
  List<RetrievedPartReasonListData>? productRequiredReasonList;
  @JsonKey(includeToJson: false, includeFromJson: false)
  String? remark;
  @JsonKey(includeToJson: false, includeFromJson: false)
  String? s3Url;
  @JsonKey(includeToJson: false, includeFromJson: false)
  String? reasonLabel;
  @JsonKey(includeToJson: false, includeFromJson: false)
  int? reasonId;
  @JsonKey(includeToJson: false, includeFromJson: false)
  String? barcode;

  RetrievedPartListResponseData({
    this.categoryCode,
    this.partRequestId,
    this.partRequestName,
    this.productRequiredReasonList,
    this.remark,
    this.s3Url,
    this.reasonId,
    this.reasonLabel,
    this.barcode,
  });

  static RetrievedPartListResponseData fromJson(Map<String, dynamic> data) =>
      _$RetrievedPartListResponseDataFromJson(data);

  Map<String, dynamic> toJson() => _$RetrievedPartListResponseDataToJson(this);
}
