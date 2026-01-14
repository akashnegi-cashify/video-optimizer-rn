import 'package:json_annotation/json_annotation.dart';

part 'scan_bin_lot_list_response.g.dart';

@JsonSerializable()
class ScanBinLotListResponse {
  @JsonKey(name: 'data')
  List<ScanBinLotItem?>? lotList;

  // @JsonKey(name: 'tc')
  // int? totalCount;
  //
  // @JsonKey(name: 's')
  // bool? status;
  //
  // @JsonKey(name: 'success')
  // bool? success;

  ScanBinLotListResponse({this.lotList});

  static ScanBinLotListResponse fromJson(Map<String, dynamic> data) => _$ScanBinLotListResponseFromJson(data);

  Map<String, dynamic> toJson() => _$ScanBinLotListResponseToJson(this);

  // bool isValid() {
  //   return status == true;
  // }
}

@JsonSerializable()
class ScanBinLotItem {
  static ScanBinLotItem fromJson(Map<String, dynamic> data) => _$ScanBinLotItemFromJson(data);

  Map<String, dynamic> toJson() => _$ScanBinLotItemToJson(this);

  @JsonKey(name: 'barcode', includeIfNull: false)
  String? barcode;

  @JsonKey(name: 'lotItemLocation', includeIfNull: false)
  String? itemLocBarCode;

  @JsonKey(name: 'storagePosition', includeIfNull: false)
  int? storagePosition;

  @JsonKey(name: 'productTitle', includeIfNull: false)
  String? productTitle;

  ScanBinLotItem({
    this.storagePosition,
    this.barcode,
    this.itemLocBarCode,
    this.productTitle,
  });
}
