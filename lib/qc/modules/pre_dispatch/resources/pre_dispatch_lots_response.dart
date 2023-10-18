import 'package:json_annotation/json_annotation.dart';

part 'pre_dispatch_lots_response.g.dart';

@JsonSerializable()
class PreDispatchLotsResponse {
  @JsonKey(name: "dt")
  List<PreDispatchLotInfo?>? lots;

  @JsonKey(name: "tc")
  int? totalLot;

  @JsonKey(name: "s")
  bool? isSuccess;

  static PreDispatchLotsResponse fromJson(Map<String, dynamic> data) => _$PreDispatchLotsResponseFromJson(data);

  Map<String, dynamic> toJson() => _$PreDispatchLotsResponseToJson(this);

  PreDispatchLotsResponse({
    this.lots,
    this.totalLot,
    this.isSuccess,
  });
}

@JsonSerializable()
class PreDispatchLotInfo {
  @JsonKey(name: "lgn")
  String? lotGroupName;

  @JsonKey(name: "lc")
  int? lotQty;

  @JsonKey(name: "sp")
  int? pendingQty;

  @JsonKey(name: "sd")
  int? scannedQty;

  @JsonKey(name: "lt")
  String? lotType;

  PreDispatchLotInfo({
    this.lotGroupName,
    this.lotQty,
    this.pendingQty,
    this.scannedQty,
    this.lotType,
  });

  static PreDispatchLotInfo fromJson(Map<String, dynamic> data) => _$PreDispatchLotInfoFromJson(data);

  Map<String, dynamic> toJson() => _$PreDispatchLotInfoToJson(this);
}
