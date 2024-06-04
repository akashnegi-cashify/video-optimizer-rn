// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'd2c_device_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

D2CDeviceDetailResponse _$D2CDeviceDetailResponseFromJson(
        Map<String, dynamic> json) =>
    D2CDeviceDetailResponse(
      json['dt'] == null
          ? null
          : D2CDeviceDetail.fromJson(json['dt'] as Map<String, dynamic>),
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    );

Map<String, dynamic> _$D2CDeviceDetailResponseToJson(
        D2CDeviceDetailResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'dt': instance.response,
    };

D2CDeviceDetail _$D2CDeviceDetailFromJson(Map<String, dynamic> json) =>
    D2CDeviceDetail()
      ..deviceBarcode = json['qr'] as String?
      ..modelName = json['mn'] as String?;

Map<String, dynamic> _$D2CDeviceDetailToJson(D2CDeviceDetail instance) =>
    <String, dynamic>{
      'qr': instance.deviceBarcode,
      'mn': instance.modelName,
    };
