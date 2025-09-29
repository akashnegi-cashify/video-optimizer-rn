// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scanned_device_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScannedDeviceDetailResponse _$ScannedDeviceDetailResponseFromJson(
        Map<String, dynamic> json) =>
    ScannedDeviceDetailResponse(
      json['error'] as bool?,
      json['ermsg'] as String?,
      json['mo'] as String?,
      json['br'] as String?,
      json['st'] as String?,
      json['src'] as String?,
      (json['el'] as num?)?.toInt(),
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    );

Map<String, dynamic> _$ScannedDeviceDetailResponseToJson(
        ScannedDeviceDetailResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'error': instance.isError,
      'ermsg': instance.errorMsg,
      'mo': instance.modal,
      'br': instance.brand,
      'st': instance.status,
      'src': instance.source,
      'el': instance.eligible,
    };
