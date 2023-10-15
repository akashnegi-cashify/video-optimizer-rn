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
      ..totalCount = json['tc'] as int?
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
      id: json['id'] as int?,
      qrCode: json['qr_code'] as String?,
      model: json['m'] as String?,
      brand: json['b'] as String?,
      imei: json['im'] as String?,
      stockBarcode: json['stbr'] as String?,
      storagePosition: json['p'] as int?,
    );

Map<String, dynamic> _$ScanNormalLotItemToJson(ScanNormalLotItem instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('qr_code', instance.qrCode);
  writeNotNull('m', instance.model);
  writeNotNull('b', instance.brand);
  writeNotNull('im', instance.imei);
  writeNotNull('stbr', instance.stockBarcode);
  writeNotNull('p', instance.storagePosition);
  return val;
}
