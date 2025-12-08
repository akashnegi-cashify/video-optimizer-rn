import 'package:json_annotation/json_annotation.dart';

part 'scan_normal_lot_list_response.g.dart';

@JsonSerializable()
class ScanNormalLotListResponse {
  @JsonKey(name: 'dt')
  List<ScanNormalLotItem?>? lotList;

  @JsonKey(name: 'tc')
  int? totalCount;

  @JsonKey(name: 's')
  bool? status;

  @JsonKey(name: 'success')
  bool? success;

  ScanNormalLotListResponse({this.lotList});

  static ScanNormalLotListResponse fromJson(Map<String, dynamic> data) => _$ScanNormalLotListResponseFromJson(data);

  Map<String, dynamic> toJson() => _$ScanNormalLotListResponseToJson(this);

  bool isValid() {
    return status == true;
  }
}

@JsonSerializable()
class ScanNormalLotItem {
  static ScanNormalLotItem fromJson(Map<String, dynamic> data) => _$ScanNormalLotItemFromJson(data);

  Map<String, dynamic> toJson() => _$ScanNormalLotItemToJson(this);

  // v1/store-out/devices response fields
  @JsonKey(name: 'deviceId', includeIfNull: false)
  int? deviceId;

  @JsonKey(name: 'qrCode', includeIfNull: false)
  String? qrCode;

  @JsonKey(name: 'model', includeIfNull: false)
  String? model;

  @JsonKey(name: 'brand', includeIfNull: false)
  String? brand;

  @JsonKey(name: 'imei', includeIfNull: false)
  String? imei;

  @JsonKey(name: 'storageBarcode', includeIfNull: false)
  String? storageBarcode;

  @JsonKey(name: 'position', includeIfNull: false)
  int? position;

  ScanNormalLotItem({
    this.deviceId,
    this.qrCode,
    this.model,
    this.brand,
    this.imei,
    this.storageBarcode,
    this.position,
  });
}
