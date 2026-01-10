// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_bin_lot_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScanBinLotListResponse _$ScanBinLotListResponseFromJson(
        Map<String, dynamic> json) =>
    ScanBinLotListResponse(
      lotList: (json['data'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : ScanBinLotItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ScanBinLotListResponseToJson(
        ScanBinLotListResponse instance) =>
    <String, dynamic>{
      'data': instance.lotList,
    };

ScanBinLotItem _$ScanBinLotItemFromJson(Map<String, dynamic> json) =>
    ScanBinLotItem(
      storagePosition: (json['storagePosition'] as num?)?.toInt(),
      barcode: json['barcode'] as String?,
      itemLocBarCode: json['lotItemLocation'] as String?,
      productTitle: json['productTitle'] as String?,
    );

Map<String, dynamic> _$ScanBinLotItemToJson(ScanBinLotItem instance) =>
    <String, dynamic>{
      if (instance.barcode case final value?) 'barcode': value,
      if (instance.itemLocBarCode case final value?) 'lotItemLocation': value,
      if (instance.storagePosition case final value?) 'storagePosition': value,
      if (instance.productTitle case final value?) 'productTitle': value,
    };
