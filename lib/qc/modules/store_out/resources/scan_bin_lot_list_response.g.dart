// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_bin_lot_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScanBinLotListResponse _$ScanBinLotListResponseFromJson(
        Map<String, dynamic> json) =>
    ScanBinLotListResponse(
      lotList: (json['dt'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : ScanBinLotItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ScanBinLotListResponseToJson(
        ScanBinLotListResponse instance) =>
    <String, dynamic>{
      'dt': instance.lotList,
    };

ScanBinLotItem _$ScanBinLotItemFromJson(Map<String, dynamic> json) =>
    ScanBinLotItem(
      storagePosition: (json['sp'] as num?)?.toInt(),
      barcode: json['bc'] as String?,
      itemLocBarCode: json['il'] as String?,
      productTitle: json['pt'] as String?,
    );

Map<String, dynamic> _$ScanBinLotItemToJson(ScanBinLotItem instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('bc', instance.barcode);
  writeNotNull('il', instance.itemLocBarCode);
  writeNotNull('sp', instance.storagePosition);
  writeNotNull('pt', instance.productTitle);
  return val;
}
