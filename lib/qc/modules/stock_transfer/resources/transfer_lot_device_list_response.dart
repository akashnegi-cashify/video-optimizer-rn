import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transfer_lot_device_list_response.g.dart';

@JsonSerializable()
class TransferLotDetailListResponse extends BaseResponse {
  @JsonKey(name: "data")
  List<TransferLotDetailListData>? data;

  TransferLotDetailListResponse(this.data, super.cashifyAlert, super.trackUrl);

  static TransferLotDetailListResponse fromJson(Map<String, dynamic> json) {
    // Support multiple list container shapes: data (List), data.data (List), or dt (List)
    dynamic rawList = json["data"];
    if (rawList is Map<String, dynamic>) {
      // Try common nested keys
      rawList = rawList["data"] ??
          rawList["rows"] ??
          rawList["content"] ??
          rawList["items"] ??
          rawList["list"];
    }
    rawList ??= json["dt"];

    List<TransferLotDetailListData>? parsedList;
    if (rawList is List) {
      parsedList = rawList
          .whereType<Map<String, dynamic>>()
          .map((e) => TransferLotDetailListData.fromJson(e))
          .toList();
    }

    final cashifyAlert =
        json["__ca"] != null ? CashifyAlert.fromJson(json["__ca"] as Map<String, dynamic>) : null;
    final trackUrl = json["turl"] as String?;

    return TransferLotDetailListResponse(parsedList, cashifyAlert, trackUrl);
  }

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

  @JsonKey(name: "model")
  String? model;

  @JsonKey(name: "brand")
  String? brand;

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
    this.imei1,
    this.imei2,
    this.serialNumber,
    this.createdBy,
    this.createDate,
    this.receiveDate,
    this.receivedBy,
  );

  static TransferLotDetailListData fromJson(Map<String, dynamic> json) =>
      _$TransferLotDetailListDataFromJson(json);

  Map<String, dynamic> toJson() => _$TransferLotDetailListDataToJson(this);
}



