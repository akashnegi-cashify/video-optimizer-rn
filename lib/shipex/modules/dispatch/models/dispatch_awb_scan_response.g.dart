// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dispatch_awb_scan_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DispatchAwbScanResponse _$DispatchAwbScanResponseFromJson(
        Map<String, dynamic> json) =>
    DispatchAwbScanResponse(
      json['name'] as String?,
      json['awb'] as String?,
      json['isVal'] as bool?,
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    );

Map<String, dynamic> _$DispatchAwbScanResponseToJson(
        DispatchAwbScanResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'name': instance.name,
      'awb': instance.awbNumber,
      'isVal': instance.isValid,
    };
