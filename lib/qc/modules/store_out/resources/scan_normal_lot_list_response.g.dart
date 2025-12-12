// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_normal_lot_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScanNormalLotListResponse _$ScanNormalLotListResponseFromJson(
        Map<String, dynamic> json) =>
    ScanNormalLotListResponse(
      lotList: (json['dt'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : ScanNormalLotItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..totalCount = (json['tc'] as num?)?.toInt()
      ..status = json['s'] as bool?
      ..success = json['success'] as bool?;

Map<String, dynamic> _$ScanNormalLotListResponseToJson(
        ScanNormalLotListResponse instance) =>
    <String, dynamic>{
      'dt': instance.lotList,
      'tc': instance.totalCount,
      's': instance.status,
      'success': instance.success,
    };

ScanNormalLotItem _$ScanNormalLotItemFromJson(Map<String, dynamic> json) =>
    ScanNormalLotItem(
      deviceId: (json['deviceId'] as num?)?.toInt(),
      qrCode: json['qrCode'] as String?,
      model: json['model'] as String?,
      brand: json['brand'] as String?,
      imei: json['imei'] as String?,
      storageBarcode: json['storageBarcode'] as String?,
      position: (json['position'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ScanNormalLotItemToJson(ScanNormalLotItem instance) =>
    <String, dynamic>{
      if (instance.deviceId case final value?) 'deviceId': value,
      if (instance.qrCode case final value?) 'qrCode': value,
      if (instance.model case final value?) 'model': value,
      if (instance.brand case final value?) 'brand': value,
      if (instance.imei case final value?) 'imei': value,
      if (instance.storageBarcode case final value?) 'storageBarcode': value,
      if (instance.position case final value?) 'position': value,
    };
