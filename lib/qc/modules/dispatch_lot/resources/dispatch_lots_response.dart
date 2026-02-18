import 'package:json_annotation/json_annotation.dart';

part 'dispatch_lots_response.g.dart';

@JsonSerializable()
class DispatchLotsResponse {
  @JsonKey(name: "dt")
  List<Lot?>? lots;

  @JsonKey(name: "tc")
  int? totalLot;

  static DispatchLotsResponse fromJson(Map<String, dynamic> data) => _$DispatchLotsResponseFromJson(data);

  Map<String, dynamic> toJson() => _$DispatchLotsResponseToJson(this);

  DispatchLotsResponse({
    this.lots,
    this.totalLot,
  });
}

@JsonSerializable()
class Lot {

  @JsonKey(name: "lotGroupName")
  String? lotGroupName;

  @JsonKey(name: "lotName")
  String? lotName;

  @JsonKey(name: "invoiceNo")
  String? invoiceNumber;

  @JsonKey(name: "invoiceDate")
  int? invoiceDate;

  @JsonKey(name: "deviceCount")
  int? deviceQty;

  @JsonKey(name: "vendorCode")
  String? vendorCode;

  @JsonKey(name: "vendorName")
  String? vendorName;

  Lot({
    this.lotGroupName,
    this.lotName,
    this.invoiceNumber,
    this.invoiceDate,
    this.deviceQty,
    this.vendorCode,
    this.vendorName,
  });

  static Lot fromJson(Map<String, dynamic> data) => _$LotFromJson(data);

  Map<String, dynamic> toJson() => _$LotToJson(this);
}
