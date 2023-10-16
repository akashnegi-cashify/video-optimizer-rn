// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'st_lot_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StLotDetailResponse _$StLotDetailResponseFromJson(Map<String, dynamic> json) =>
    StLotDetailResponse(
      json['ln'] as String?,
      json['mo'] as String?,
      json['qr'] as String?,
      json['dst'] as String?,
      json['lo'] as String?,
      json['dcnt'] as int?,
      json['scnt'] as int?,
      json['st'] as String?,
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    );

Map<String, dynamic> _$StLotDetailResponseToJson(
        StLotDetailResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'ln': instance.lotName,
      'mo': instance.modelName,
      'qr': instance.barcode,
      'dst': instance.destination,
      'lo': instance.location,
      'dcnt': instance.deviceCount,
      'scnt': instance.scanCount,
      'st': instance.storage,
    };
