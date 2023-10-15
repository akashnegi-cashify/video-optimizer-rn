import 'package:json_annotation/json_annotation.dart';

part 'scan_bin_lot_list_response.g.dart';

@JsonSerializable()
class ScanBinLotListResponse {
  @JsonKey(name: 'dt')
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

  @JsonKey(name: 'bc', includeIfNull: false)
  String? barcode;

  @JsonKey(name: 'il', includeIfNull: false)
  String? itemLocBarCode;

  @JsonKey(name: 'sp', includeIfNull: false)
  int? storagePosition;

  @JsonKey(name: 'pt', includeIfNull: false)
  String? productTitle;

  ScanBinLotItem({
    this.storagePosition,
    this.barcode,
    this.itemLocBarCode,
    this.productTitle,
  });
}
