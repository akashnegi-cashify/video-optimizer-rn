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
      id: (json['id'] as num?)?.toInt(),
      qrCode: json['qr_code'] as String?,
      model: json['m'] as String?,
      brand: json['b'] as String?,
      imei: json['im'] as String?,
      stockBarcode: json['stbr'] as String?,
      storagePosition: (json['p'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ScanNormalLotItemToJson(ScanNormalLotItem instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.qrCode case final value?) 'qr_code': value,
      if (instance.model case final value?) 'm': value,
      if (instance.brand case final value?) 'b': value,
      if (instance.imei case final value?) 'im': value,
      if (instance.stockBarcode case final value?) 'stbr': value,
      if (instance.storagePosition case final value?) 'p': value,
    };
