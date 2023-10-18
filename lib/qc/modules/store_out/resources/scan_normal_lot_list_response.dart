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

  @JsonKey(name: 'id', includeIfNull: false)
  int? id;

  @JsonKey(name: 'qr_code',includeIfNull: false)
  String? qrCode;

  @JsonKey(name: 'm', includeIfNull: false)
  String? model;

  @JsonKey(name: 'b', includeIfNull: false)
  String? brand;

  @JsonKey(name: 'im', includeIfNull: false)
  String? imei;

  @JsonKey(name: 'stbr', includeIfNull: false)
  String? stockBarcode;

  @JsonKey(name: 'p', includeIfNull: false)
  int? storagePosition;

  ScanNormalLotItem({
    this.id,
    this.qrCode,
    this.model,
    this.brand,
    this.imei,
    this.stockBarcode,
    this.storagePosition,
  });
}
