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
  @JsonKey(name: "lotId")
  int? lotId;

  @JsonKey(name: "lotGroupName")
  String? lotGroupName;

  @JsonKey(name: "lotCount")
  int? lotCount;

  @JsonKey(name: "scanPending")
  int? scanPending;

  @JsonKey(name: "scanDone")
  int? scanDone;

  @JsonKey(name: "channel")
  String? channel;

  @JsonKey(name: "lotType")
  String? lotType;

  PreDispatchLotInfo({
    this.lotId,
    this.lotGroupName,
    this.lotCount,
    this.scanPending,
    this.scanDone,
    this.channel,
    this.lotType,
  });

  static PreDispatchLotInfo fromJson(Map<String, dynamic> data) => _$PreDispatchLotInfoFromJson(data);

  Map<String, dynamic> toJson() => _$PreDispatchLotInfoToJson(this);
}
