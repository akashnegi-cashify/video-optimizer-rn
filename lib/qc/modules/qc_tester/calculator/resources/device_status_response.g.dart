// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_status_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceStatusResponse _$DeviceStatusResponseFromJson(
        Map<String, dynamic> json) =>
    DeviceStatusResponse(
      json['status'] as String?,
      (json['salesChannels'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      (json['stockAge'] as num?)?.toInt(),
      json['isCaptureQcImages'] as bool?,
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    );

Map<String, dynamic> _$DeviceStatusResponseToJson(
        DeviceStatusResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'status': instance.status,
      'salesChannels': instance.salesChannels,
      'stockAge': instance.stockAge,
      'isCaptureQcImages': instance.isCaptureQcImages,
    };
