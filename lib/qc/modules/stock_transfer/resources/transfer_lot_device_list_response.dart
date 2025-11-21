import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transfer_lot_device_list_response.g.dart';

@JsonSerializable()
class TransferLotDetailListResponse extends BaseResponse {
  @JsonKey(name: "data")
  List<TransferLotDetailListData>? data;

  TransferLotDetailListResponse(this.data, super.cashifyAlert, super.trackUrl);

  static TransferLotDetailListResponse fromJson(Map<String, dynamic> json) =>
      _$TransferLotDetailListResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TransferLotDetailListResponseToJson(this);
}

@JsonSerializable()
class TransferLotDetailListData {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "statusCode")
  int? statusCode;

  @JsonKey(name: "qrCode")
  String? qrCode;

  @JsonKey(name: "lotName")
  String? lotName;

  @JsonKey(name: "location")
  String? location;

  @JsonKey(name: "model")
  String? model;

  @JsonKey(name: "brand")
  String? brand;

  @JsonKey(name: "source")
  String? source;

  @JsonKey(name: "imei1")
  String? imei1;

  @JsonKey(name: "imei2")
  String? imei2;

  @JsonKey(name: "serialNumber")
  String? serialNumber;

  @JsonKey(name: "createdBy")
  String? createdBy;

  @JsonKey(name: "createDate")
  int? createDate;

  @JsonKey(name: "receiveDate")
  int? receiveDate;

  @JsonKey(name: "receivedBy")
  String? receivedBy;

  TransferLotDetailListData(
    this.id,
    this.statusCode,
    this.qrCode,
    this.lotName,
    this.model,
    this.brand,
    this.source,
    this.imei1,
    this.imei2,
    this.location,
    this.serialNumber,
    this.createdBy,
    this.createDate,
    this.receiveDate,
    this.receivedBy,
  );

  static TransferLotDetailListData fromJson(Map<String, dynamic> json) => _$TransferLotDetailListDataFromJson(json);

  Map<String, dynamic> toJson() => _$TransferLotDetailListDataToJson(this);
}
