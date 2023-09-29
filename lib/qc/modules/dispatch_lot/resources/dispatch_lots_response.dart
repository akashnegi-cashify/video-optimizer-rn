import 'package:json_annotation/json_annotation.dart';

part 'dispatch_lots_response.g.dart';

@JsonSerializable()
class DispatchLotsResponse {
  @JsonKey(name: "dt")
  List<Lot?>? lots;

  @JsonKey(name: "tc")
  int? totalLot;

  @JsonKey(name: "s")
  bool? isSuccess;

  static DispatchLotsResponse fromJson(Map<String, dynamic> data) => _$DispatchLotsResponseFromJson(data);

  Map<String, dynamic> toJson() => _$DispatchLotsResponseToJson(this);

  DispatchLotsResponse({
    this.lots,
    this.totalLot,
    this.isSuccess,
  });
}

@JsonSerializable()
class Lot {
  @JsonKey(name: "lgn")
  String? lotGroupName;

  @JsonKey(name: "ln")
  String? lotName;

  @JsonKey(name: "in")
  String? invoiceNumber;

  @JsonKey(name: "idt")
  int? invoiceDate;

  @JsonKey(name: "dc")
  int? deviceQty;

  @JsonKey(name: "vc")
  String? vendorCode;

  @JsonKey(name: "vn")
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
