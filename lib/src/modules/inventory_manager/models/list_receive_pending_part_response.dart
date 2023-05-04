import 'package:json_annotation/json_annotation.dart';

part 'list_receive_pending_part_response.g.dart';

@JsonSerializable()
class ListReceivePendingPartResponse {
  @JsonKey(name: "r_id")
  String? rid;
  @JsonKey(name: "s")
  bool? isSuccess;
  @JsonKey(name: "dt")
  List<ListResponsePendingDataResponse>? dataList;

  ListReceivePendingPartResponse({
    this.isSuccess,
    this.rid,
    this.dataList,
  });

  static ListReceivePendingPartResponse fromJson(Map<String, dynamic> data) =>
      _$ListReceivePendingPartResponseFromJson(data);

  Map<String, dynamic> toJson() => _$ListReceivePendingPartResponseToJson(this);
}

@JsonSerializable()
class ListResponsePendingDataResponse {
  @JsonKey(name: "prid")
  int? prid;
  @JsonKey(name: "sku")
  String? sku;

  @JsonKey(name: "pn")
  String? partName;

  @JsonKey(name: "pc")
  String? partColour;

  @JsonKey(name: "st")
  String? status;

  @JsonKey(name: "stc")
  int? statusCode;

  @JsonKey(name: "rqty")
  int? requestedQuantity;

  @JsonKey(name: "pbr")
  String? partBarcode;

  @JsonKey(name: "isBulk")
  bool? isBulk;

  ListResponsePendingDataResponse({
    this.prid,
    this.partBarcode,
    this.partName,
    this.isBulk,
    this.sku,
    this.status,
    this.statusCode,
    this.partColour,
    this.requestedQuantity,
  });

  static ListResponsePendingDataResponse fromJson(Map<String, dynamic> data) =>
      _$ListResponsePendingDataResponseFromJson(data);

  Map<String, dynamic> toJson() => _$ListResponsePendingDataResponseToJson(this);
}
