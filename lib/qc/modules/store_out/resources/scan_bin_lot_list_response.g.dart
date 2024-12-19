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

Map<String, dynamic> _$ScanBinLotItemToJson(ScanBinLotItem instance) =>
    <String, dynamic>{
      if (instance.barcode case final value?) 'bc': value,
      if (instance.itemLocBarCode case final value?) 'il': value,
      if (instance.storagePosition case final value?) 'sp': value,
      if (instance.productTitle case final value?) 'pt': value,
    };
